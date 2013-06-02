# "mscvvowyflrtoPltotzvrtbkaojiieqssxhjSrgzraojlayvrogzzivfvsHrghsrmrpvenvoengprupe".split(//).inject({}){|h,k|if h[k]; h[k] = h[k] + 1
#                                              ; else h[k] = 0; end; h}.each {|k,v| puts "#{k}\t#{v}" }

text = ARGF.read.gsub(/\s/, '').downcase
chars = text.split(//).inject({}) do |h, k|
  if h[k]
    h[k] = h[k] + 1
  else
    h[k] = 1
  end
  h
end.to_a

chars.sort! {|kv1, kv2| v1 = kv1.last; v2 = kv2.last; v1 <=> v2}

chars.each do |kv|
  k, v = kv
  puts "#{k}\t#{v}"
end


