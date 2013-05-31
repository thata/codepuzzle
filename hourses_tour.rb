require './utility.rb'

module HoursesTour
  class Solver
    def initialize(grid)
      @grid = grid
    end

    def solve(x, y)
      @path = []
      @solutions = []
      solve_with_backtracking(x, y, 1)
      @solutions
    end

    def solve_with_backtracking(x, y, k)
      @path << [x, y]
      if k == 9
        @solutions << @path.clone if can_move?(x, y, @path[0][0], @path[0][1])
      else
        movable_positions(x, y).each{|nx, ny|
          if @grid.cell(nx, ny).to_i == k+1
            solve_with_backtracking(nx, ny, k+1)
          end
        }
      end
      @path.pop
    end

    def can_move?(sx, sy, tx, ty)
      target = [tx, ty]
      movable_positions(sx, sy).include?(target)
    end

    def movable_positions(x, y)
      result = Set[]
      # 上
      result << [x, y - 1] if (y - 1) > 0
      # 右
      result << [x - 1, y] if (x - 1) > 0
      # 下
      result << [x, y + 1] if (y + 1) <= 9
      # 左
      result << [x + 1, y] if (x + 1) <= 9
      # 左下
      for i in x..9
        yy = y + (i - x)
        if yy <= 9
          result << [i, yy]
        end
      end
      # 右上
      for i in 1..x
        yy = y - (x - i)
        if yy >= 1
          result << [i, yy]
        end
      end
      # 左上
      for i in x..9
        yy = y - (i - x)
        if yy >= 1
          result << [i, yy]
        end
      end
      # 右下
      for i in 1..x
        yy = y + (x - i)
        if yy <= 9
          result << [i, yy]
        end
      end
      
      result = result - Set[[x, y]]

      # puts "mp(#{x}, #{y}): #{ result.each.to_a }"

      result
    end


  end
end
