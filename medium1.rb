=begin listening device

class Device
  attr_reader :recordings
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    if block_given? && yield != ""
      record(yield)
    end
  end

  def play
    puts recordings
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.play # Outputs "Hello World!"

=end

=begin text analyzer - sandwich code

=end

=begin passing parameters part1

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  yield if block_given?
end

gather(items) {|item| puts "Let's start gathering food. \n#{items.join(', ')} \nNice selection of food we have gathered!"}

or

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield if block_given?
  puts "Nice selection of food we have gathered!"
end

gather(items) {|item| puts items.join(', ')}

=end

=begin passing parameters part 2

birds = %w(raven finch hawk eagle)

def call_birds(array)
  yield(array) if block_given?
end

call_birds(birds) {|bird1, bird2, *bird| puts "#{bird.join(', ')}"}

=end

=begin passing parameters part 3

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

# gather(items) do |*item_3, item|
#   puts "#{item_3.join(', ')}"
#   puts "#{item}"
# end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

# gather(items) do |first_item ,*two_items , last_item|
#   puts "#{first_item}"
#   puts "#{two_items.join(', ')}"
#   puts "#{last_item}"
# end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

# gather(items) do |first_item , *other_items|
#   puts "#{first_item}"
#   puts "#{other_items.join(', ')}"
# end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

# gather(items) do |first , second, third, fourth|
#   puts "#{first}, #{second}, #{third}, and #{fourth}"
# end

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!

=end

=begin method to proc

=end

=begin bubble sort with blocks

=end