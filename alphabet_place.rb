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

    def solve_with_backtracking
      solve_simple()                  # まず、答が確定するところは解き進めます

      next_z = @grid.index("Z")

      return true if next_z.nil?   # もう0が残っていない＝解答発見

      ## 以下を RUBYIST, ILOVERUBY をapplyした結果の各候補に対してぐるぐるまわすと良さそうな...

      # Z のマスに対して、候補を一つずつ仮置きしてみます
      x, y = @grid.index2pos(next_z)
      list_candidates(x, y).each{|k|
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
      candidates - row_cells(@grid, y) - col_cells(@grid, x) - block_cells(@grid, x, y)
    end

    def apply(pattern)
      def _(grid, pattern)
        regexp = Regexp.new(pattern.split(//).map {|c| ("[#{c}Z]") }.join) 
        grid.sub(regexp, pattern)
      end

      # XXX 改行を意識せず置き換える
      [_(@grid, pattern)]
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
    
    def block_cells(grid, x, y)
      xs = friend_of(x)
      ys = friend_of(y)
      selected_rows = ys.map {|n| grid.to_grid.split[n - 1] }
      selected_cols = selected_rows.map do |l|
        # XXX String.grid_size 未対応
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
