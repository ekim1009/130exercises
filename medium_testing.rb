=begin classes to test
done!
=end

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  
  def test_accept_money
    register = CashRegister.new(5000)
    transaction = Transaction.new(10)
    transaction.amount_paid = 10
    
    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money
    assert_equal(previous_amount + 10, current_amount)
  end
  
  def test_change
    register = CashRegister.new(5000)
    transaction = Transaction.new(90)
    transaction.amount_paid = 100
 
    assert_equal(10, register.change(transaction))
  end
  
  def test_give_receipt
    item_cost = 35
    register = CashRegister.new(1000)
    transaction = Transaction.new(item_cost)
    assert_output("You've paid $#{item_cost}.\n") do
      register.give_receipt(transaction)
    end
  end
  
end


class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(100)
    input = StringIO.new('100\n')
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal 100, transaction.amount_paid
  end
end


=begin swap letters sample text and starter file
=end

=begin test swap method
=end

=begin test word count method
=end