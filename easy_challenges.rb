=begin triangles

=end

=begin point mutations

class DNA
  attr_reader :strand

  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(other_dna)
    return 0 if strand == other_dna
    if strand.size == other_dna.size
      same_strand_length(other_dna)
    elsif strand.size > other_dna.size
      current_strand_longer(other_dna)
    else #strand.size < other_dna.size
      other_strand_longer(other_dna)
    end
  end

  def same_strand_length(other_dna)
    count = 0
    (0...strand.size).each do |idx|
      count += 1 if strand[idx] != other_dna[idx]
    end
    count
  end

  def current_strand_longer(other_dna)
    size = other_dna.size
    dna = strand[0, size]
    count = 0
    (0...size).each do |idx|
      count += 1 if dna[idx] != other_dna[idx] 
    end
    count
  end

  def other_strand_longer(other_dna)
    size = strand.size
    dna = other_dna[0, size]
    count = 0
    (0...size).each do |idx|
      count += 1 if strand[idx] != dna[idx] 
    end
    count
  end
end

require 'minitest/autorun'
# require_relative 'point_mutations'

class DNATest < Minitest::Test
  def test_no_difference_between_empty_strands
    assert_equal 0, DNA.new('').hamming_distance('')
  end

  def test_no_difference_between_identical_strands
    assert_equal 0, DNA.new('GGACTGA').hamming_distance('GGACTGA')
  end

  def test_complete_hamming_distance_in_small_strand
    assert_equal 3, DNA.new('ACT').hamming_distance('GGA')
  end

  def test_hamming_distance_in_off_by_one_strand
    strand = 'GGACGGATTCTGACCTGGACTAATTTTGGGG'
    distance = 'AGGACGGATTCTGACCTGGACTAATTTTGGGG'
    assert_equal 19, DNA.new(strand).hamming_distance(distance)
  end

  def test_small_hamming_distance_in_middle_somewhere
    assert_equal 1, DNA.new('GGACG').hamming_distance('GGTCG')
  end

  def test_larger_distance
    assert_equal 2, DNA.new('ACCAGGG').hamming_distance('ACTATGG')
  end

  def test_ignores_extra_length_on_other_strand_when_longer
    assert_equal 3, DNA.new('AAACTAGGGG').hamming_distance('AGGCTAGCGGTAGGAC')
  end

  def test_ignores_extra_length_on_original_strand_when_longer
    strand = 'GACTACGGACAGGGTAGGGAAT'
    distance = 'GACATCGCACACC'
    assert_equal 5, DNA.new(strand).hamming_distance(distance)
  end

  def test_does_not_actually_shorten_original_strand
    dna = DNA.new('AGACAACAGCCAGCCGCCGGATT')
    assert_equal 1, dna.hamming_distance('AGGCAA')
    assert_equal 4, dna.hamming_distance('AGACATCTTTCAGCCGCCGGATTAGGCAA')
    assert_equal 1, dna.hamming_distance('AGG')
  end
end

=end

=begin roman numerals

=end

=begin anagrams

=end

=begin scrabble score

class Scrabble
  attr_reader :string

  def initialize(string)
    @string = string
  end

  def score
    return 0 if string == nil || string.empty? 
    total = 0
    string.downcase.chars.each do |letter|
      case 
      when " " == letter then total = 0; return total
      when %(a e i o u l n r s t).include?(letter) then total += 1
      when %(d g).include?(letter) then total += 2
      when %(b c m p).include?(letter) then total += 3
      when %(f h v w y).include?(letter) then total += 4
      when "k" == letter then total+= 5
      when %(j x).include?(letter) then total += 8
      when %(q z).include?(letter) then total += 10
      end 
    end
    total
  end

	def self.score(string)
    Scrabble.new(string).score
  end

end

require 'minitest/autorun'
# require_relative 'scrabble_score'

class ScrabbleTest < Minitest::Test
  def test_empty_word_scores_zero
    assert_equal 0, Scrabble.new('').score
  end

  def test_whitespace_scores_zero
    assert_equal 0, Scrabble.new(" \t\n").score
  end

  def test_nil_scores_zero
    assert_equal 0, Scrabble.new(nil).score
  end

  def test_scores_very_short_word
    assert_equal 1, Scrabble.new('a').score
  end

  def test_scores_other_very_short_word
    assert_equal 4, Scrabble.new('f').score
  end

  def test_simple_word_scores_the_number_of_letters
    assert_equal 6, Scrabble.new('street').score
  end

  def test_complicated_word_scores_more
    assert_equal 22, Scrabble.new('quirky').score
  end

  def test_scores_are_case_insensitive
    assert_equal 41, Scrabble.new('OXYPHENBUTAZONE').score
  end

  def test_convenient_scoring
    assert_equal 13, Scrabble.score('alacrity')
  end
end

=end

=begin perfect number

class PerfectNumber
  def self.classify(int)
    raise StandardError if int < 0
  
    total = (1...int).select do |num|
      int % num == 0
    end.sum

    if total == int
      "perfect"
    elsif total > int
      "abundant"
    else
      "deficient"
    end

  end
end

require 'minitest/autorun'
# require_relative 'perfect_numbers'

class PerfectNumberTest < Minitest::Test
  def test_initialize_perfect_number
    assert_raises StandardError do
      PerfectNumber.classify(-1)
    end
  end

  def test_classify_deficient
    assert_equal 'deficient', PerfectNumber.classify(13)
  end

  def test_classify_perfect
    assert_equal 'perfect', PerfectNumber.classify(28)
  end

  def test_classify_abundant
    assert_equal 'abundant', PerfectNumber.classify(12)
  end
end

=end

=begin octal

=end

=begin sum of multiples

Write a program that, given a natural number and a set of one or more other numbers, can find the sum of all the multiples of the numbers in the set that are less than the first number. If the set of numbers is not given, use a default set of 3 and 5.

For instance, if we list all the natural numbers up to, but not including, 20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of these multiples is 78.

-------------- P 
input: integer and set of numbers, if no sets provided, default to 3 and 5
output: integer - the sum of the multiples



-------------- E 
require 'minitest/autorun'
require_relative 'sum_of_multiples'

class SumTest < Minitest::Test
  def test_sum_to_1
    assert_equal 0, SumOfMultiples.to(1)
  end

  def test_sum_to_3
    skip
    assert_equal 3, SumOfMultiples.to(4) [3]
  end

  def test_sum_to_10
    skip
    assert_equal 23, SumOfMultiples.to(10) [3, 5, 6, 9]
  end
  
  def test_configurable_7_13_17_to_20
    skip
    assert_equal 51, SumOfMultiples.new(7, 13, 17).to(20) [7, 13, 14, 17]
  end
   assert_equal 30, SumOfMultiples.new(4, 6).to(15) [4, 6, 8, 12]


   rules:
  - find the sum of all the unique values of the multiples
  - multiples should be up to but not including the target number
-------------- D
- range of integers
- array
-------------- A 

- create a class called SumOfMultiples
- create a constructor method which should accept a number of integers - but if no values are given, default the values to 3 and 5
  - initialize an instance variable and have it point to the number of given integers 
- create a class method called `to` which should accept one integer
  - create a instance 
  - call to `to` method and pass in the target integer
- create an instance method called `to` which should accept one integer
  - iterate through a range starting from 1 up to but not including the target number
    - iterate through the array of divisors
      - retrieve the integers which are evenly divisible by the current divisor
  - find the unique values and then find the sum of the array
=end

=begin
class SumOfMultiples
  def initialize(*divisors)
    if divisors.empty?
      @divisors = [3,5]
    else
      @divisors = divisors
    end
  end

  def self.to(target_int)
    self.new.to(target_int)
  end

  def to(target_int)
    result = []
    1.upto(target_int - 1) do |current_int|
      @divisors.each do |divisor|
        result << current_int if current_int % divisor == 0
      end
    end
    result.uniq.sum
  end
end


require 'minitest/autorun'
# require_relative 'sum_of_multiples'

class SumTest < Minitest::Test
  def test_sum_to_1
    assert_equal 0, SumOfMultiples.to(1)
  end

  def test_sum_to_3
    assert_equal 3, SumOfMultiples.to(4)
  end

  def test_sum_to_10
    assert_equal 23, SumOfMultiples.to(10)
  end

  def test_sum_to_100
    assert_equal 2_318, SumOfMultiples.to(100)
  end

  def test_sum_to_1000
    assert_equal 233_168, SumOfMultiples.to(1000)
  end

  def test_configurable_7_13_17_to_20
    assert_equal 51, SumOfMultiples.new(7, 13, 17).to(20)
  end

  def test_configurable_4_6_to_15
    assert_equal 30, SumOfMultiples.new(4, 6).to(15)
  end

  def test_configurable_5_6_8_to_150
    assert_equal 4419, SumOfMultiples.new(5, 6, 8).to(150)
  end

  def test_configurable_43_47_to_10000
    assert_equal 2_203_160, SumOfMultiples.new(43, 47).to(10_000)
  end
end

=end

=begin beer song

=end

=begin series

=end