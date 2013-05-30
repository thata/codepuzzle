require 'set'
require './utility.rb'

module NumberPlace
  class Solver
    def initialize(grid)
      @grid = grid
    end

    def solve
      for x in 1..9
        for y in 1..9
          candidates = list_candidates(x, y)
          unless candidates.empty?
            n = candidates.first
            @grid.set_cell(x, y, n)
          end
        end
      end
      @grid
    end

    def list_candidates(x, y)
      # binding.pry
      candidates = Set[1, 2, 3, 4, 5, 6, 7, 8, 9]
      candidates - row_cells(@grid, y) - col_cells(@grid, x) - block_cells(@grid, x, y)
    end

    private 

    # 横一列
    def row_cells(grid, y)
      grid.to_grid.split[y - 1].split(//).map do |n|
        n.to_i
      end.each_with_object(Set[]) do |n, s|
        s << n
      end
    end

    # 縦一列
    def col_cells(grid, x)
      grid.to_grid.split.map {|line|
        line.reverse[x - 1]
      }.map {|s|
        s.to_i
      }.each_with_object(Set[]) { |n, s|
        s << n
      }
    end
    
    def block_cells(grid, x, y)
      xs = friend_of(x)
      ys = friend_of(y)
      selected_rows = ys.map {|n| @grid.to_grid.split[n - 1] }
      selected_cols = selected_rows.map{|s|s.reverse}.map{|l|l[xs[0] - 1] + l[xs[1] - 1] + l[xs[2] - 1]}
      result = selected_cols.map{|line| line.split(//)}.flatten.uniq.map{|s| s.to_i}.each_with_object(Set[]) {|n, s| s << n }
      result
    end

    def friend_of(n)
      case n
      when 1..3
        [1, 2, 3]
      when 4..6
        [4, 5, 6]
      when 7..9
        [7, 8, 9]
      end
    end
  end
end
