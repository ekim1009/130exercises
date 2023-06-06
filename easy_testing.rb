require 'minitest/autorun'

=begin boolean assertions

class TestValue < Minitest::Test
  def test_
    @value = 4
    assert(@value.odd?)
  end
end

=end

=begin equality assertions

class TestString < Minitest::Test
  def test_
    @value = "Hi"
    assert_equal('xyz', @value.downcase)
  end
end

=end

=begin nil assertions

class TestNilAssertion < Minitest::Test
  def test_nil
    @value = 'Hi'
    assert_nil(@value)
  end
end

=end

=begin empty object assertions

class Test_not_empty < Minitest::Test
  def test_empty
    @array = [1, 2]
    assert_equal([], @array)
  end
end

=end

=begin included object 

class Test_array_list < Minitest::Test
  def test_array_list
    @array = ["hi", "bye"]
    assert_includes(@array, 'xyz')
  end
end

=end

=begin exception assertions

NoExperienceError = Class.new(StandardError)

class Employee
  def hire
    raise NoExperienceError, 'This person does not have experience'
  end
end

class Test_employee < Minitest::Test
  def test_hireable
    @employee = Employee.new
    assert_raises(NoExperienceError) { @employee.hire }
  end
end

=end

=begin type assertions

class Test_instance_of < Minitest::Test
  def test_instance_of
    @value = Numeric.new
    assert_instance_of(Numeric, @value)
  end
end

=end

=begin kind assertions

class Test_numeric_subclass < Minitest::Test
  def test_numeric
    @value = 5
    assert_kind_of(Numeric, @value)
  end
end

=end

=begin same object assertions

class List
  
  def process
    List.new
  end
  
end

class Test_same_object < Minitest::Test
  def test_same_object
    @list = List.new
    assert_same(@list, @list.process)
  end
end

=end

=begin refutations


class Test_refutation < Minitest::Test
  def test_refutation
    @array = ['hi', 'abc', 'xyz']
    refute_includes(@array, 'xyz')
  end
end

=end