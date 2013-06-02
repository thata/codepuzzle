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

text = ARGV.shift
passwd = ARGV.shift
# # $password の先頭4文字
# $plain_text = decode_vigenere($text, (the $password))
# raise "checksum error" unless check_sum($plain_text[1..-1])

puts decode_vigenere(text, passwd)

# n = 0 # 0 .. 456951
# ("AAAA".."ZZZZ").each do |pwsswd|
#   plain_text = decode_vigenere($text, (the $password))
#   puts "passwd: #{passwd} text: #{plain_text}" if check_sum(plain_text[1..-1])
#   n = n + 1
#   $stderr.puts "# #{n}" if n % 100000 == 0
#   
# end
