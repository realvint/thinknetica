#Станция
class Station
  attr_accessor :trains, :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end

  def train_arrive(train) #Принять поезд
    trains.push(train)
  end

  def trains_list_type(type) #Список всех поездов на станции по типу (грузовой/пассажирский)
    trains.select { |i| i.type == type }
  end

  def train_depart(train) #Отправить поезд
    trains.delete(train)
  end
end

# Маршруты
class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  def add(station) #Добавить промежуточную станцию
    @stations.insert(-2, station)
  end

  def delete(station) #Удалить промеждуточную станцию
    @stations.delete(station)
  end

  def route_list #Список всех станций
    @stations.each_with_index{ |station, index| puts "#{index + 1}. #{station}"}
  end
end

#Поезда
class Train
  attr_accessor :speed, :wagon, :type, :route, :route

  def initialize(number, type, wagons)
    @number = number.to_s
    @type = type
    @speed = 0
    @wagons = wagons
  end

  def speed_up #Набирать скорость
    @speed += 20
  end

  def speed #Текущая скорость
    @speed
  end

  def stop #Тормозить (сбрасывать скорость до нуля)
      @speed = 0
  end

  def wagons_count #Количество вагонов
    @wagons
  end

  def add_wagon #Прицепить вагон
    if speed.zero?
      @wagons += 1
    end
  end

  def delete_wagon #Отцепить вагон (проверки на нулевое и отрицательное количество вагонов нет в ТЗ )
    if speed.zero?
      @wagons -= 1
    end
  end

  def take_route(route) #Принять маршрут следования
    @station_index = 0
    @current_station = route.route_list.first
  end

  def go_next_station #Вперёд на одну станцию
    if @station_index < @route.length - 1
      @station_index += 1
      @current_station[@station_index]
    end
  end

  def go_prev_station #Назад на одну станцию
    if @station_index > 0
      @station_index -= 1
      @current_station[@station_index]
    end
  end

  def current_station
    @current_station[@station_index]
  end

end



