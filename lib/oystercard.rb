
class Oystercard 
  attr_reader :balance, :entry_station
  MAX__BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "Balance cannot exceed £#{MAX__BALANCE}" if (@balance + value) > MAX__BALANCE

    @balance += value
  end


  def touch_in(entry_station)
    fail 'insufficient balance' if balance < MIN_BALANCE
    
    @in_journey = true
    @entry_station = entry_station
  end

  def in_journey?
    @in_journey 
  end

  def touch_out
    @in_journey = false
    deduct(1)
  end

  private

    def deduct(value)
    @balance -= value
    end
  
end