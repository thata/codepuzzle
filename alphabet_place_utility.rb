class String
  @@grid_size = 25

  def self.grid_size() @@grid_size end

  def self.grid_size=(n) @@grid_size = n end

  def pos2index(x, y)
    # (1,1) (2,1) (3,1) .. (25,1)
    # ..
    # (1,25) (2,25) (3,25) .. (25,25)
    (x - 1) + ((y - 1) * @@grid_size)
  end

  def index2pos(n)
    # [@@grid_size - n%@@grid_size, n/@@grid_size + 1]
    x = (n % @@grid_size) + 1
    y = (n / @@grid_size) + 1
    [x, y]
  end

  def cell(x, y)
    self[pos2index(x, y),1]
  end

  def set_cell(x, y, c)
    self[pos2index(x, y)] = c.to_s
  end

  def to_grid
    self.gsub(/.{#{@@grid_size}}/, "\\0\n")
  end
end


# for compatibility

unless String.method_defined?(:bytes)
  class String
    def bytes
      ret = []
      each_byte{|b| ret << b}
      ret
    end
  end
end

unless Array.method_defined?(:rotate)
  class Array
    def rotate(n)
      slice(n%size..-1) + slice(0, n%size)
    end
  end
end

unless Enumerable.method_defined?(:each_slice)
  module Enumerable
    def each_slice(n)
      if block_given?
        args = []
        each {|v|
          args << v
          if args.size == n
            yield args
            args = []
          end
        }
        yield args unless args.empty?
      else
        ret = []
        each_slice(n){|arr| ret << arr}
        ret
      end
    end
  end
end
