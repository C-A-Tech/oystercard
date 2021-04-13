
class Oystercard 
  attr_reader :entry_station, :exit_station, :journey_history
  attr_accessor :balance
  
  MAX__BALANCE = 90
  MIN_BALANCE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = []
  end

  def top_up(value)
    fail "Balance cannot exceed £#{MAX__BALANCE}" if maximun_balance?(value)
    @balance += value
  end


  def touch_in(entry_station)
    fail 'insufficient balance' if balance < MIN_BALANCE
    @exit_station = nil
    @entry_station = entry_station
    
  end

  def in_journey?
    !@entry_station.nil? # in_journey returns true if entry_station is not nil & viceversa
  end

  def touch_out(exit_station)
    deduct(MIN_BALANCE)    
    @exit_station = exit_station
    @journey_history << {"Entry Station" => @entry_station, "Exit Station" => @exit_station}
    @entry_station = nil
  end

  private

    def deduct(value)
      @balance -= value
    end

    def maximun_balance?(value)
      (@balance + value) > MAX__BALANCE
    end
  
end