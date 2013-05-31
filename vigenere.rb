def encode_char(chr, key)
  shift = key.bytes.to_a[0] - "A".bytes.to_a[0]
  puts "shift: #{ shift }"
  table = ("a".."z").to_a.join
  puts "table: #{ table }"
  chr.upcase
end

def encode_vigenere(text, passwd)
  i = 0
  len = passwd.length
  text.split(//).each do |chr|
    encode_char(chr, passwd[i % len])
    i = i + 1
  end.join
end

def decode_vigenere(text, passwd)
end
