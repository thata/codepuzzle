require 'set'
require './utility.rb'

module AlphabetPlace
  class Solver
    def initialize(grid)
      @grid = grid
    end

    def solve
#      solve_with_backtracking
      @grid
    end

    def solve_simple
#      for x in 2..9
#        for y in 1..9
#          next if @grid.cell(x, y).to_i > 0
#          candidates = list_candidates(x, y)
#          if candidates.empty?
#            # do nothing
#          elsif candidates.size == 1
#            n = candidates.first
#            @grid.set_cell(x, y, n)
#          else
#            # do nothing
#          end
#        end
#      end
#      @grid
    end

    def solve_with_backtracking
#      solve_simple()                  # まず、答が確定するところは解き進めます
#
#      next_zero = @grid.index("0")
#      return true if next_zero.nil?   # もう0が残っていない＝解答発見
#
#      # 0 のマスに対して、候補を一つずつ仮置きしてみます
#      x, y = @grid.index2pos(next_zero)
#      list_candidates(x, y).each{|k|
#        saved_grid = @grid.clone      # 盤面を保存しておく
#        @grid.set_cell(x, y, k)       # 数字を仮置きする
#
#        if solve_with_backtracking()
#          return true                 # 答が見つかったら盤面を @grid に残したままで終了
#        end
#
#        @grid = saved_grid            # 汚れた盤面を保存した状態に戻す
#      }
#      return false                    # 答が見つからなかった
    end

    def list_candidates(x, y)
#      candidates = Set[1, 2, 3, 4, 5, 6, 7, 8, 9]
#      candidates - row_cells(@grid, y) - col_cells(@grid, x) - block_cells(@grid, x, y)
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
#    
#    def block_cells(grid, x, y)
#      xs = friend_of(x)
#      ys = friend_of(y)
#      selected_rows = ys.map {|n| @grid.to_grid.split[n - 1] }
#      selected_cols = selected_rows.map{|s|s.reverse}.map{|l|l[xs[0] - 1] + l[xs[1] - 1] + l[xs[2] - 1]}
#      result = selected_cols.map{|line| line.split(//)}.flatten.uniq.map{|s| s.to_i}.each_with_object(Set[]) {|n, s| s << n }
#      result
#    end
#
#    def friend_of(n)
#      case n
#      when 1..3
#        [1, 2, 3]
#      when 4..6
#        [4, 5, 6]
#      when 7..9
#        [7, 8, 9]
#      end
#    end
  end
end
