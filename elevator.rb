class ElevatorBank
  attr_accessor :floors, :elevators, :pickup_queue

  def initialize(floors)
    @floors = floors
    @elevators = []
    @pickup_queue = []
  end

  def summon(floor)
    @pickup_queue << floor
  end

  def send_to_pickup
    floor = @pickup_queue.pop
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
  attr_accessor :floor, :dropoff_queue, :bank

  def initialize(bank, start_floor=1)
    @bank = bank
    bank.elevators << self
    @floor = start_floor
    @dropoff_queue = []
  end

  def go_to(destination)
    # why does this need to be an instance variable?
    @floor = destination
  end

  def take_me_to(floor)
    dropoff_queue << floor
  end

  def send_to_dropoff
    floor = nearest_dropoff
    go_to(floor)
    dropoff_queue.delete(floor)
  end

  def nearest_dropoff
    current_distance = bank.floors
    next_dropoff = nil
    @dropoff_queue.each do |dropoff_request|
      if (floor - dropoff_request).abs < current_distance
        current_distance = (floor - dropoff_request).abs
        next_dropoff = dropoff_request
      end
    end
    next_dropoff
  end

end