# frozen_string_literal: true
require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  attr_reader :speed, :wagons, :number, :type

  NUMBER_FORMAT = /^\w{3}-*\w{2}$/.freeze
  TYPE_FORMAT = /^(passenger|cargo)$/.freeze

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  validate :type, :presence
  validate :type, :format, TYPE_FORMAT

  def initialize(number, type)
    register_instance
    @type = type
    @number = number
    validate!
    @speed = 0
    @wagons = []
    self.class.trains ||= []
    self.class.trains << self
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def self.trains
    @trains ||= []
  end

  def self.find(number)
    @trains.select { |train| train.number == number }
  end

  def speed_up
    @speed += 20
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if speed.zero?
  end

  def delete_wagon
    @wagons.pop if speed.zero?
  end

  def wagons_each(&block)
    @wagons.each { |wagon| block.call(wagon) }
  end

  def take_route(route)
    @route = route
    @station_index = 0
    @route.route[@station_index].train_arrive(self)
  end

  def go_next_station
    return unless show_next_station

    @route.route[@station_index].train_depart(self)
    @station_index += 1
    @route.route[@station_index].train_arrive(self)
  end

  def go_prev_station
    return unless show_prev_station

    @route.route[@station_index].train_depart(self)
    @station_index -= 1
    @route.route[@station_index].train_arrive(self)
  end

  private

  def current_station
    @route.route[@station_index]
  end

  def show_next_station
    @route.route[@station_index + 1]
  end

  def show_prev_station
    @route.route[@station_index - 1]
  end
end
