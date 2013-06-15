require 'test/unit'
require './alphabet_place.rb'
require './alphabet_place_utility.rb'

class TestCase_AlphabetPlaceSolver < Test::Unit::TestCase
  def setup
    @grid = <<GRID25.delete("\n")
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
  end

  def test_block_range
    solver = AlphabetPlace::Solver.new(nil)
    assert_equal([1, 2, 3, 4, 5], solver.block_xrange(1))
    assert_equal([6, 7, 8, 9, 10], solver.block_xrange(2))
    assert_equal([21, 22, 23, 24, 25], solver.block_xrange(5))
    assert_equal([1, 2, 3, 4, 5], solver.block_xrange(6))
    assert_equal([21, 22, 23, 24, 25], solver.block_xrange(25))
  end

  def test_block_cells
    grid = <<GRID25.delete("\n")
AZZZZBZZZZCCZZZDZZZZEFZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
FZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZZ
ZZZZZZZZZZZZZZZZZZZZZZZZY
GRID25

    assert_equal(
      Set['A','Z'],
      AlphabetPlace::Solver.new(nil).__send__(:block_cells, grid, 1, 1))
    assert_equal(
      Set['B','Z'],
      AlphabetPlace::Solver.new(nil).__send__(:block_cells, grid, 6, 1))
    assert_equal(
      Set['C','Z'],
      AlphabetPlace::Solver.new(nil).__send__(:block_cells, grid, 11, 1))
    assert_equal(
      Set['E','F','Z'],
      AlphabetPlace::Solver.new(nil).__send__(:block_cells, grid, 21, 1))
    assert_equal(
      Set['F','Z'],
      AlphabetPlace::Solver.new(nil).__send__(:block_cells, grid, 1, 6))
    assert_equal(
      Set['Y','Z'],
      AlphabetPlace::Solver.new(nil).__send__(:block_cells, grid, 25, 25))
  end

  def test_col_cells
    assert_equal(
      Set['A','Z','W','D','F','M','R','I','Q','B','Y','G','X','S'],
      AlphabetPlace::Solver.new(nil).__send__(:col_cells, @grid, 1))
    assert_equal(
      Set['E','R','Z','I','W','G','B','Y','H','T','X','P','K'],
      AlphabetPlace::Solver.new(nil).__send__(:col_cells, @grid, 25))
  end

  def test_row_cells
    assert_equal(Set['A','P','Z','T','W','F','O','C','E'], AlphabetPlace::Solver.new(nil).__send__(:row_cells, @grid, 1))
    assert_equal(Set['S','P','Z','B','N','G','U','K','C','A','R','I'], AlphabetPlace::Solver.new(nil).__send__(:row_cells, @grid, 25))
  end

  def test_list_candidates
    solver = AlphabetPlace::Solver.new(<<GRID25.delete("\n"))
ZBCDEFGHIJKLMNOPQRSTUVWXY
ZZZZZZZZZZZZZZZZZZZZABCDE
ZCZZZZZZZZZZZZZZZZZZKLMNO
ZDZZZZZZZZZZZZZZZZZZFGHIJ
ZEZZZZZZZZZZZZZZZZZZPQRSZ
ZFZZZZZZZZZZZZZZZZZZZZZZZ
ZGZZZZZZZZZZZZZZZZZZZZZZZ
ZHZZZZZZZZZZZZZZZZZZZZZZZ
ZIZZZZZZZZZZZZZZZZZZZZZZZ
ZJZZZZZZZZZZZZZZZZZZZZZZZ
ZKZZZZZZZZZZZZZZZZZZZZZZZ
ZLZZZZZZZZZZZZZZZZZZZZZZZ
ZMZZZZZZZZZZZZZZZZZZZZZZZ
ZNZZZZZZZZZZZZZZZZZZZZZZZ
ZOZZZZZZZZZZZZZZZZZZZZZZZ
ZPZZZZZZZZZZZZZZZZZZZZZZZ
ZQZZZZZZZZZZZZZZZZZZZZZZZ
ZRZZZZZZZZZZZZZZZZZZZZZZZ
ZSZZZZZZZZZZZZZZZZZZZZZZZ
ZXZZZZZZZZZZZZZZZZZZZZZZZ
ZUZZZZZZZZZZZZZZZZZZZZZZZ
ZVZZZZZZZZZZZZZZZZZZZZZZZ
ZWZZZZZZZZZZZZZZZZZZZZZZZ
ZTZZZZZZZZZZZZZZZZZZZZZZZ
ZABCDEFGHIJKLMNOPQRSTUVWZ
GRID25
    assert_equal(Set['A'], solver.list_candidates(1, 1))
    assert_equal(Set[], solver.list_candidates(2, 1))
    assert_equal(Set[], solver.list_candidates(3, 1))
    assert_equal(Set['Y'], solver.list_candidates(2, 2))
    assert_equal(Set['T'], solver.list_candidates(25, 5))
    assert_equal(Set['X', 'Y'], solver.list_candidates(1, 25))
    assert_equal(Set['X'], solver.list_candidates(25, 25))
  end


  def test_solve_0_super_easy
    String.grid_size = 5
    solver = AlphabetPlace::Solver.new(<<GRID.delete("\n"))
ABCDE
FGHIJ
KLMNO
PQRST
ZZZZZ
GRID
    assert_equal(<<GRID.delete("\n"), solver.solve())
ABCDE
FGHIJ
KLMNO
PQRST
UVWXY
GRID
  end

#  def test_solve_1_easy
#    solver = NumberPlace::Solver.new(<<GRID.delete("\n"))
#100050004
#040609080
#009000200
#060000090
#700000008
#010000020
#002000700
#050806040
#300010005
#GRID
#    assert_equal(<<GRID.delete("\n"), solver.solve())
#126358974
#547629183
#839147256
#263784591
#795261438
#418593627
#682435719
#951876342
#374912865
#GRID
#  end
#
#  def test_solve_2_normal
#    solver = NumberPlace::Solver.new(<<GRID.delete("\n"))
#100009004
#800652070
#000000600
#760000000
#090000050
#010000026
#004000700
#050306000
#300004001
#GRID
#    assert_equal(<<GRID.delete("\n"), solver.solve())
#126739584
#849652173
#537418692
#763245819
#298163457
#415897326
#684921735
#951376248
#372584961
#GRID
#  end

=begin
  def test_solve_3_hard
    solver = NumberPlace::Solver.new(<<GRID.delete("\n"))
900500800
080060090
007084305
520100400
060040050
004005900
000000500
408090000
000200001
GRID
    assert_equal(<<GRID.delete("\n"), solver.solve())
943512876
285367194
617984325
529173468
761849253
834625917
172436589
458791632
396258741
GRID
  end

  def test_solve_4_super_hard
    solver = NumberPlace::Solver.new(<<GRID.delete("\n"))
600402001
080000050
003000700
000507000
450000068
000803000
006000400
020000070
300905002
GRID
    assert_equal(<<GRID.delete("\n"), solver.solve())
675482931
184739256
293156784
832567149
457291368
961843527
716328495
529614873
348975612
GRID
  end
=end

end

class TestCase_AlphabetPlaceUtility < Test::Unit::TestCase
  def setup
    @grid = <<GRID25.delete("\n")
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
  end

  def test_pos2index
    String.grid_size = 25
    assert_equal(0, @grid.pos2index(1, 1))
    assert_equal(1, @grid.pos2index(2, 1))
    assert_equal(624, @grid.pos2index(25, 25))
  end

  def test_index2pos
    String.grid_size = 25
    assert_equal([1, 1], @grid.index2pos(0))
    assert_equal([2, 1], @grid.index2pos(1))
    assert_equal([1, 2], @grid.index2pos(25))
    assert_equal([25, 25], @grid.index2pos(624))
  end
end
