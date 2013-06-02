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

passwords = %w(
RNKA
RNGA
RNOA
RJKA
RJGA
RJOA
RRKA
RRGA
RROA
NNKA
NNGA
NNOA
NJKA
NJGA
NJOA
NRKA
NRGA
NROA
VNKA
VNGA
VNOA
VJKA
VJGA
VJOA
VRKA
VRGA
VROA
)
n = 0 # 0 .. 456951
passwords.each do |passwd|
  plain_text = decode_vigenere($text, (the passwd))
  # puts "passwd: #{passwd} text: #{plain_text}" if check_sum(plain_text[1..-1])
  puts plain_text
  n = n + 1
  $stderr.puts "# #{n}" if n % 100000 == 0
end
