# final_puzzle.rb

require './alphabet_place.rb'

$grid = <<GRID25.delete("\n")
AZZPZZTZZZZZZWFZZZOZCZZZE
ZZZXFQBZZZASJZZUYZZLTZZZR
ZJDLUPOCZZKZNZZQHZZZSZZZZ
ZKZZZZZZZZEZBHZTZGZWMZJZZ
ZWZZZZFZZUTYPZZVEMZZZZZQI
ZZZZTZZKVZZZZZZBFOZEZZZXZ
ZXYVMBSZZZUDZZZZZZZZZZZZZ
WZZZZFQZXZZZLZZNRZZYZZZZZ
ZZZSPECZATMKYOZZZZZZJZZVW
ZIZZAMZZZZZZZZZZCVZZZZEZZ
DZNAZZZZZSZUZZZZZZPZVIZHG
ZZZZZLZZZAQPZZVZZZZRZZCZZ
ZZKZZZGBOZZZZZZZMNHULZZZZ
FZUZHZZTQYJZZCAIVZZZZDZKB
ZQZZZZZZHPOZZRZWGTCSZMUNY
MATZZJPZLZHZZZZZQWZZZNZRZ
RZZJSZZYZCZQZEZZZUZHZZZZZ
IFCZZTZEZZZZKMRPZZZZZZZOH
QZZDZVZINZBZXSOYZAEZZZGZT
BLEOVZZSZZZZZYUJTZKZZZWPX
YDFKCWZAZIZZZZZMZZZGNEZUP
GZZZQZUZZZNZZZZZZLZZZZYZZ
XMZWZZZFZKZZZZZZZZZZDZZZZ
ZEZIZZZZRDZHZZZOZZZAGJBZK
SZPZBZZNZZZGZUZZKCZZZARIZ
GRID25

$partial_grid = [
                 "ILOVERUBY",
                 "R\nU\nB\nY\nI\nS\nT"
                ]

puts AlphabetPlace::Solver.new($grid).solve.to_grid
