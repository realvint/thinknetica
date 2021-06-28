# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter
  attr_reader :name, :route

  NAME_FORMAT = /^[а-яa-z]{3}$/i.freeze

  def initialize(name, first_station, last_station)
    register_instance
    @name = name
    validate!
    @route = [first_station, last_station]
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add(station)
    @route.insert(-2, station)
  end

  def delete(station)
    @route.delete(station)
  end

  def route_list
    @route.each_with_index { |station, index| puts "#{index + 1}. #{station}" }
  end

  private

  def validate!
    raise StandardError, 'Ошибка! формат названия маршрута: три буквы' if name !~ NAME_FORMAT
  end
end
