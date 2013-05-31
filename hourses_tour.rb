module HoursesTour
  class Solver
    def initialize(grid)
      @grid = grid
    end

    def solve(x, y)
    end

    def can_move?(sx, sy, tx, ty)
    end

    def movable_positions(x, y)
      result = Set[]
      # 上
      result << [x, y - 1]
      # 右
      result << [x - 1, y]
      # 下
      result << [x, y + 1]
      # 左
      result << [x + 1, y]
      # 左下
      for i in x..9
        yy = y + (i - x)
        if y <= 9
          result << [i, yy]
        end
      end
      # 右上
      for i in 1..x
        yy = y - (x - i)
        if y >= 1
          result << [i, yy]
        end
      end
      # 左上
      for i in x..9
        yy = y - (i - x)
        if y >= 1
          result << [i, yy]
        end
      end
      # 右下
      for i in 1..x
        yy = y + (x - i)
        if y <= 9
          result << [i, yy]
        end
      end
      
      result - Set[[x, y]]
    end


  end
end
