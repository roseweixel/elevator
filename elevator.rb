class ElevatorBank
  attr_accessor :floors, :elevators, :queue

  def initialize(floors)
    @floors = floors
    @elevators = []
    @queue = []
  end

  def summon(floor)
    # implement queue later
    # @queue << floor
    closest_elevator(floor).go_to(floor)
  end

  def closest_elevator(floor)
    current_distance = floors
    chosen_elevator = nil
    @elevators.each do |elevator|
      if (elevator.floor - floor).abs < current_distance
        current_distance = (elevator.floor - floor).abs
        chosen_elevator = elevator
      end
    end
    chosen_elevator
  end

end

class Elevator
  attr_accessor :floor

  def initialize(bank, start_floor=1)
    bank.elevators << self
    @floor = start_floor
  end

  def go_to(destination)
    # why does this need to be an instance variable?
    @floor = destination
  end

end