# Станция
class Station
  attr_reader :trains, :name

  def initialize(name)
    @name = name
    @trains = []
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