require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :taken_unit_quantity, :number

  def initialize(unit_quantity)
    @number = rand(100)
    @type = :cargo
    @unit_quantity = unit_quantity
    @taken_unit_quantity = 0
  end

  def take_unit(quantity)
    raise "Недостаточно объема в вагоне" if quantity > free_unit_quantity
    self.taken_unit_quantity += quantity
  end

  def free_unit_quantity
    self.unit_quantity - taken_unit_quantity
  end

  protected
  attr_accessor :unit_quantity
end