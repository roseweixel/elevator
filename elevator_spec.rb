require 'pry'
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
    let(:bank) { ElevatorBank.new(7) }
    let!(:near_elevator) { Elevator.new(bank, 2) }
    let!(:far_elevator) { Elevator.new(bank) }

    it "should add an elevator request to the queue" do
      expect{bank.summon(1)}.to change{bank.pickup_queue.count}.from(0).to(1)
    end
  end

  describe "#send_to_pickup" do
    let(:bank) { ElevatorBank.new(7) }
    let!(:near_elevator) { Elevator.new(bank, 2) }
    let!(:far_elevator) { Elevator.new(bank) }

    before(:each) do
      bank.summon(5)
    end

    it "should remove the first request from the pickup_queue" do
      expect{bank.send_to_pickup}.to change{bank.pickup_queue.count}.from(1).to(0)
    end

    it "send the nearest elevator to the requested floor" do
      expect{bank.send_to_pickup}.to change{near_elevator.floor}.from(2).to(5)
    end
  end

  describe "#closest_elevator" do
    it "should find the elevator closest to the request" do
      expect(bank.closest_elevator(5)).to be_nil

      near_elevator = Elevator.new(bank, 2)
      far_elevator = Elevator.new(bank)

      expect(bank.closest_elevator(5)).to eq(near_elevator)
    end
  end
end

describe Elevator do
  let(:bank) { ElevatorBank.new(7) }
  let(:elevator) { Elevator.new(bank) }

  describe "#go_to" do
    it "should change the floor to the one it was sent to" do
      expect{
        elevator.go_to(5)
      }.to change{elevator.floor}.from(1).to(5)
    end
  end

  describe "#take_me_to" do
    it "should add a request to be dropped off to the dropoff_queue" do

      expect{
        elevator.take_me_to(5)
      }.to change{elevator.dropoff_queue.count}.from(0).to(1)

      expect(elevator.dropoff_queue).to include(5)
    end
  end

  describe "#send_to_dropoff" do
    it "should send the elevator to the nearest dropoff request in its dropoff_queue and delete the request" do
      elevator.take_me_to(3)
      elevator.take_me_to(4)

      expect(elevator.dropoff_queue.size).to eq(2)

      expect{ 
        elevator.send_to_dropoff
        }.to change{elevator.floor}.from(1).to(3)

      expect(elevator.dropoff_queue.size).to eq(1)
      
    end
  end

end