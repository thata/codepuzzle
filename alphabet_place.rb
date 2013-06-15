require 'set'
require './alphabet_place_utility.rb'

module AlphabetPlace
  class Solver
    def initialize(grid)
      @grid = grid
    end

    def solve
      solve_with_backtracking
      @grid
    end

    def solve_simple
      for x in 1..String.grid_size
        for y in 1..String.grid_size
          next if @grid.cell(x, y) != 'Z'
          candidates = list_candidates(x, y)
          if candidates.empty?
            # do nothing
          elsif candidates.size == 1
            n = candidates.first
            @grid.set_cell(x, y, n)
          else
            # do nothing
          end
        end
      end
      @grid
    end

    # 候補がもっとも少ない Z を返す
    def super_next_z
      # next_z = (1..5).map {|x| (16..20).map {|y| [x, y] }}.flatten(1).map {|x, y| [(x - 1) + ((y - 1) * String.grid_size), list_candidates(x, y).size] }.reject {|xy, n| n == 0 }.sort {|x, y| x[1] <=> y[1] }.first
      next_z = (1..String.grid_size).map {|x| (1..String.grid_size).map {|y| [x, y] }}.flatten(1).map {|x, y| [(x - 1) + ((y - 1) * String.grid_size), list_candidates(x, y).size] }.reject {|xy, n| n == 0 }.sort {|x, y| x[1] <=> y[1] }.first
      if next_z
        next_z[0]
      else
        # 候補が無くなったけど、Zは残ってる？
        @grid.index("Z")
        # nil
      end
    end

    def hyper_next_z
      blocks = sort_block_by_n_of_candidate((1..25).to_a)
      blocks.each do |block|
        xrange = block_xrange(block)
        yrange = block_yrange(block)
        next_z = xrange.map {|x| yrange.map {|y| [x, y] }}.flatten(1).map {|x, y| [(x - 1) + ((y - 1) * String.grid_size), list_candidates(x, y).size] }.reject {|xy, n| n == 0 }.sort {|x, y| x[1] <=> y[1] }.first
        if next_z
          return next_z[0]
        end
      end
      @grid.index("Z")
    end

    def solve_with_backtracking
      solve_simple()                  # まず、答が確定するところは解き進めます

      next_z = hyper_next_z
      # next_z = super_next_z

      return true if next_z.nil?   # もう0が残っていない＝解答発見

      # Z のマスに対して、候補を一つずつ仮置きしてみます
      x, y = @grid.index2pos(next_z)
      list_candidates(x, y).each{|k|
        # debug
        puts "---"
        puts @grid.to_grid

        saved_grid = @grid.clone      # 盤面を保存しておく
        @grid.set_cell(x, y, k)       # 数字を仮置きする

        if solve_with_backtracking()
          return true                 # 答が見つかったら盤面を @grid に残したままで終了
        end

        @grid = saved_grid            # 汚れた盤面を保存した状態に戻す
      }
      return false                    # 答が見つからなかった
    end

    def list_candidates(x, y)
      candidates = Set.new('A'..'Y')
      return Set[] if @grid.cell(x, y) != 'Z'
      candidates - row_cells(@grid, y) - col_cells(@grid, x) - block_cells(@grid, x, y)
    end

    def n_of_candidate_of_block(n)
      sum = 0
      for x in block_xrange(n)
        for y in block_yrange(n)
          sum = sum + list_candidates(x, y).size
        end
      end
      sum
    end

    def sort_block_by_n_of_candidate(blocks)
      # 候補数が少ない順に並べる
      blocks.map {|block| [block, n_of_candidate_of_block(block)] }.sort {|a, b| a[1] <=> b[1] }.map {|n, count| n }
    end

    def block_xrange(n)
      case (n - 1) % 5
      when 0
        (1..5).to_a
      when 1
        (6..10).to_a
      when 2
        (11..15).to_a
      when 3
        (16..20).to_a
      when 4
        (21..25).to_a
      end
    end

    def block_yrange(n)
      case (n - 1) / 5
      when 0
        (1..5).to_a
      when 1
        (6..10).to_a
      when 2
        (11..15).to_a
      when 3
        (16..20).to_a
      when 4
        (21..25).to_a
      end
    end

    private 

    # 横一列
    def row_cells(grid, y)
      grid.to_grid.split[y - 1].split(//).
        each_with_object(Set[]) do |n, s|
        s << n
      end
    end

    # 縦一列
    def col_cells(grid, x)
      grid.to_grid.split.map {|line|
        line[x - 1]
      }.each_with_object(Set[]) { |n, s|
        s << n
      }
    end
    
    def block(grid, x, y)
      xs = friend_of(x)
      ys = friend_of(y)
      selected_rows = ys.map {|n| grid.to_grid.split[n - 1] }
      selected_cols = selected_rows.map do |l|
        l[xs[0] - 1] + 
          l[xs[1] - 1] + 
          l[xs[2] - 1] + 
          l[xs[3] - 1] + 
          l[xs[4] - 1]
      end
      selected_cols
    end

    def block_cells(grid, x, y)
      xs = friend_of(x)
      ys = friend_of(y)
      selected_rows = ys.map {|n| grid.to_grid.split[n - 1] }
      selected_cols = selected_rows.map do |l|
        l[xs[0] - 1] + 
          l[xs[1] - 1] + 
          l[xs[2] - 1] + 
          l[xs[3] - 1] + 
          l[xs[4] - 1]
      end
      result = selected_cols.map{|line| line.split(//)}.flatten.uniq.each_with_object(Set[]) {|n, s| s << n }
      result
    end

    def friend_of(n)
      case n
      when 1..5
        (1..5).to_a
      when 6..10
        (6..10).to_a
      when 11..15
        (11..15).to_a
      when 16..20
        (16..20).to_a
      when 21..25
        (21..25).to_a
      end
    end
  end
end
