require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains, :name
  @@all_stations = []

  def initialize(name)
    register_instance
    @name = name
    @trains = []
    @@all_stations << self
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
end