require_relative 'elevator.rb'
# What is an elevator?
# 0. there is an elevator bank that has many elevators
# 1. should respond to a summon method
# 2. an elevator object exists
# 3. should have bottom and top floor (integers)
# 4. needs to know what floor each elevator is on

# Later
# 1. maybe add amount of people (capacity)

describe ElevatorBank do
  let(:bank) { ElevatorBank.new(7) }

  describe "#floors" do
    it "should return the number of floors the building has" do
      expect(bank.floors).to eq(7)
    end
  end

  describe "#elevators" do
    it "should return an array" do
      expect(bank.elevators.class).to eq(Array)
    end

    it "should contain all the Elevators in the ElevatorBank" do
      elevator = Elevator.new(bank)
      expect(bank.elevators).to include(elevator)
    end
  end

  describe "#summon" do
    it "should add an elevator request to the queue" do
      expect{bank.summon(1)}.to change{bank.queue.count}.from(0).to(1)
    end
  end
end

describe Elevator do
  let(:bank) { ElevatorBank.new(7) }

  describe ".new" do
    it "should create an instance of Elevator" do
      expect{
        elevator = Elevator.new(bank)
        }.to_not raise_error
    end
  end

end