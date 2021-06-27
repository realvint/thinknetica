require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :taken_unit_quantity, :number

  def initialize(unit_quantity)
    @number = rand(100)
    @type = :passenger
    @unit_quantity = unit_quantity
    @taken_unit_quantity = 0
  end

  def take_unit
    raise "Недостаточно мест в вагоне" if free_unit_quantity == 0
    self.taken_unit_quantity += 1
  end

  def free_unit_quantity
    self.unit_quantity - taken_unit_quantity
  end

  protected
  attr_accessor :unit_quantity
end