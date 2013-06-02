def encode_char(chr, key)
  shift = key.bytes.to_a[0] - "A".bytes.to_a[0]
  idx = case chr
        when /[a-z]/
          chr.bytes.to_a[0] - "a".bytes.to_a[0] 
        when /[A-Z]/
          chr.bytes.to_a[0] - "A".bytes.to_a[0] 
        else
          -1
        end
  if idx < 0
    chr
  else
    table = case chr
          when /[a-z]/
            ("a".."z").to_a.join
          when /[A-Z]/
            ("A".."Z").to_a.join
          end
    table = if shift == 0
              table
            else
              table[shift..-1] + table[0..(shift - 1)]
            end
    table[idx]
  end
end

def encode_vigenere(text, passwd)
  i = 0
  len = passwd.length
  text.split(//).map do |chr|
    encoded_chr = encode_char(chr, passwd[i % len])
    i = i + 1
    encoded_chr
  end.join
end

def decode_char(chr, key)
  return chr unless /[A-Za-z]/ =~ chr

  shift = key.bytes.to_a[0] - "A".bytes.to_a[0]
  table = case chr
        when /[a-z]/
          ("a".."z").to_a.join
        when /[A-Z]/
          ("A".."Z").to_a.join
        end
  table = if shift == 0
            table
          else
            table[shift..-1] + table[0..(shift - 1)]
          end
  hit = table.index(chr)
  if (hit < 0)
    chr
  else
    result = case chr
          when /[a-z]/
            (hit + "a".bytes.to_a[0]).chr
          when /[A-Z]/
            (hit + "A".bytes.to_a[0]).chr
          end
    result
  end
end

def decode_vigenere(text, passwd)
  i = 0
  len = passwd.length
  text.split(//).map do |chr|
    decoded_chr = decode_char(chr, passwd[i % len])
    i = i + 1
    decoded_chr
  end.join
end
