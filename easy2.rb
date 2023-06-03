=begin from-to-step sequence generator

def step(start_int, end_int, inc)
  arr = []
  until start_int > end_int
    yield(start_int)
    arr << start_int
    start_int += inc
  end
  arr
end

p step(1, 10, 3) { |value| puts "value = #{value}" }

=end

=begin zipper

def zip(array1, array2)
  arr = []
  (0...array1.size).each do |idx|
    arr << [array1[idx], array2[idx]]
  end
  arr
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

=end

=begin map

def map(array)
  arr = []
  array.each {|int| arr << yield(int)}
  arr
end

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]

=end

=begin count

def count(*args)
  count = 0
  args.each {|int| count += 1 if yield(int)}
  count
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3

=end

=begin drop_while

def drop_while(array)
  ind = 0
  array.each_with_index do |int, idx|
    if !yield(int)
      ind = idx 
      break
    else 
      ind = idx + 1
    end
  end
  ind > array.size ? [] : array[ind..-1]
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } #== [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? }# == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| true }# == []
p drop_while([1, 3, 5, 6]) { |value| false } #== [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 }# == [5, 6]
p drop_while([]) { |value| true } #== []

=end

=begin each_with_index

def each_with_index(array)
  (0...array.size).each do |idx|
    value = array[idx]
    yield(value, idx)
  end
  array
end

result = each_with_index([1, 3, 6]) do |value, index|
  puts "#{index} -> #{value**index}"
end

puts result == [1, 3, 6]

=end

=begin each_with_object

def each_with_object(array, return_array)
  array.each do |int| 
    yield(int, return_array)
  end
  return_array
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}

=end

=begin max_by

def max_by(array)
  max_idx = 0
  (0...array.size).each do |index|
    if yield(array[index]) > yield(array[max_idx])
      max_idx = index
    end
  end
  array[max_idx]
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil

=end

=begin each_cons (part 1)

def each_cons(array)
  (0...array.size - 1).each do |idx|
    yield(array[idx], array[idx + 1])
  end
  nil
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}
p result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}
p result == nil

=end

=begin each_cons (part 2)

def each_cons(array, amount)
  (0...array.size).each do |indx|
    #p array[idx, amount]
    break if indx > array.size - amount
    yield(*array[indx, amount])
  end
  nil
end

hash = {}
each_cons([1, 3, 6, 10], 1) do |value|
  hash[value] = true
end
p hash# == { 1 => true, 3 => true, 6 => true, 10 => true }

hash = {}
each_cons([1, 3, 6, 10], 2) do |value1, value2|
  hash[value1] = value2
end
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6], 3 => [6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 4) do |value1, *values|
  hash[value1] = values
end
p hash == { 1 => [3, 6, 10] }

hash = {}
each_cons([1, 3, 6, 10], 5) do |value1, *values|
  hash[value1] = values
end
p hash == {}

=end