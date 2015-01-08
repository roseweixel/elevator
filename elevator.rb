class ElevatorBank
  attr_accessor :floors, :elevators, :queue

  def initialize(floors)
    @floors = floors
    @elevators = []
    @queue = []
  end

  def summon(floor)
    @queue << floor
  end

end

class Elevator

  def initialize(bank)
    bank.elevators << self
  end

end