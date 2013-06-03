require './third_page.rb'
require './fifth_page.rb'
require './ordinals.rb'
answer = $grid.split('').values_at(*$ordinals[0..21]).each_slice(2).
  map do |x,y|
    # ここは見えない
    $grid.cell(x, y)
  end.join
puts answer

