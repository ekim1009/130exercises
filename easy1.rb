=begin enumerable class creation

class Tree
  include Enumerable
  
end

=end

=begin optional blocks

def compute
  block_given? ? yield : "Does not compute."
end

p compute { 5 + 3 } == 8
p compute { 'a' + 'b' } == 'ab'
p compute == 'Does not compute.'
=end

=begin find missing number

def missing(array)
  arr = []
  (array[0]..array[-1]).each do |idx|
    arr << idx if !array.include?(idx)
  end
  arr
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []

=end

=begin divisors

def divisors(int)
  (1..int).select do |num|
    int % num == 0
  end
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute

=end

=begin encrypted pioneers

def translate(string)
  string.downcase.tr("a-mn-z", "n-za-m")
end

p translate("Nqn Ybirynpr")
p translate("Tenpr Ubccre")
p translate("Nqryr Tbyqfgvar")
p translate("Nyna Ghevat")
p translate("Puneyrf Onoontr")
p translate("Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv")
p translate("Wbua Ngnanfbss")
p translate("Ybvf Unvog")
p translate("Pynhqr Funaaba")
p translate("Fgrir Wbof")
p translate("Ovyy Tngrf")
p translate("Gvz Orearef-Yrr")
p translate("Fgrir Jbmavnx")
p translate("Xbaenq Mhfr")
p translate("Fve Nagbal Ubner")
p translate("Zneiva Zvafxl")
p translate("Lhxvuveb Zngfhzbgb")
p translate("Unllvz Fybavzfxv")
p translate("Tregehqr Oynapu")


=end

=begin iterators: true for any?

def any?(array)
  array.each { |int| return true if yield(int) }
  false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false

=end

=begin iterators: true for all?

def all?(array)
  array.each {|int| return false if !yield(int)}
  true
end


p all?([1, 3, 5, 6]) { |value| value.odd? } == false
p all?([1, 3, 5, 7]) { |value| value.odd? } == true
p all?([2, 4, 6, 8]) { |value| value.even? } == true
p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p all?([1, 3, 5, 7]) { |value| true } == true
p all?([1, 3, 5, 7]) { |value| false } == false
p all?([]) { |value| false } == true

=end

=begin iterators: true for none?

def none?(array)
  array.each {|int| return false if yield(int)}
  true
end


p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true

=end

=begin iterators: true for one?

def one?(array)
  total = 0
  array.each { |int| total += 1 if yield(int)}
  return true if total == 1
  false
end

p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
p one?([1, 3, 5, 7]) { |value| true }           # -> false
p one?([1, 3, 5, 7]) { |value| false }          # -> false
p one?([]) { |value| true }                     # -> false

=end

=begin count items

def count(array)
  total = 0
  array.each {|int| total += 1 if yield(int)}
  total
end


p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2

=end