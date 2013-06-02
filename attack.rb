# attack.rb
require './utility.rb'
require './second_page.rb'
require './vigenere.rb'
require './password.rb'

def the(s) s[0..3].upcase end
def check_sum(s)
  sum = s.bytes.inject(0){|acc,c| acc += c}
  sum % 26 == 0
end

# # $password の先頭4文字
# $plain_text = decode_vigenere($text, (the $password))
# raise "checksum error" unless check_sum($plain_text[1..-1])

n = 0 # 0 .. 456951
("AAAA".."ZZZZ").each do |pwd|
  plain_text = decode_vigenere($text, (the pwd))
  puts "#{pwd}\t#{plain_text}" if check_sum(plain_text[1..-1]) && /block/ =~ plain_text
  n = n + 1
  $stderr.puts "# #{n}" if n % 100000 == 0
  
end
