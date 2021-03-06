require_relative "station.rb"

class Oystercard

  attr_reader :balance, :entry_station, :journeys, :exit_station

  MAX_BALANCE = 90
  MIN_JOURNEY_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(top_up_amt)
    raise 'Balance cannot exceed 90' if exceeds_max_balance?(top_up_amt)
    @balance += top_up_amt
  end


  def touch_in(entry_station)
    fail 'Cannot touch in, you do not have sufficient balance!' unless has_sufficient_balance?
    fail 'Cannot touch in, already touched in!' if in_journey?
    @entry_station = entry_station
    @exit_station = nil
  end

  def touch_out(exit_station)
    fail 'Cannot touch out, already touched out!' unless in_journey?
    deduct(1)
    @exit_station = exit_station
    add_journey
    @entry_station = nil
  end

  def in_journey?
    entry_station ? true : false
  end

private

  def add_journey
    @journeys << { entry: entry_station, exit: exit_station }
  end

  def exceeds_max_balance?(top_up_amt)
    (balance + top_up_amt) > MAX_BALANCE
  end

  def has_sufficient_balance?
    balance >= MIN_JOURNEY_BALANCE
  end

  def deduct(deduct_amt)
    @balance -= deduct_amt
  end

end
