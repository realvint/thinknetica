require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name
  @@all_stations = []

  NAME_FORMAT = /^[а-яa-z]{3}$/i

  def initialize(name)
    register_instance
    @name = name
    validate!
    @trains = []
    @@all_stations << self
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def self.all
    @@all_stations
  end

  def train_arrive(train) # Принять поезд
    @trains.push(train)
  end

  def trains_list_type(type) # Список всех поездов на станции по типу (грузовой/пассажирский)
    @trains.select { |train| train.type == type }
  end

  def train_depart(train) # Отправить поезд
    @trains.delete(train)
  end

  private

  def validate!
    raise StandardError, 'Ошибка! формат названия станции: три буквы' if name !~ NAME_FORMAT
  end
end