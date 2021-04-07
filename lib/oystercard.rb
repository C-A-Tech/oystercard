
class Oystercard 
  attr_reader :balance
  MAX__BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "Balance cannot exceed £#{MAX__BALANCE}" if (@balance + value) > MAX__BALANCE

    @balance += value
  end

  def deduct(value)
    @balance -= value
  end

  def touch_in
    fail 'insufficient balance' if balance < MIN_BALANCE
    
    @in_journey = true
  end

  def in_journey?
    @in_journey 
  end

  def touch_out
    @in_journey = false
  end
  
end