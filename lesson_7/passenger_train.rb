require_relative 'train'

class PassengerTrain < Train
  attr_reader :type, :number

  def initialize (number,type)
    super(number, type)
  end
end