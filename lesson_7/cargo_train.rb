require_relative 'train'

class CargoTrain < Train
  attr_reader :type, :number

  def initialize (number, type)
    super(number, type)
  end
end
