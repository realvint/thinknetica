# frozen_string_literal: true

require_relative 'train'

class CargoTrain < Train
  attr_reader :type, :number
end
