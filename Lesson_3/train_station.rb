#Станция
class Station
  attr_accessor :trains, :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = {}
    puts "Станция #{@station_name} создана"
  end

  def train_arrive(train = {}) #Принять поезд
    @number = train.keys.join
    @type   = train.values.join
    if @number.nil? || @type.nil?
      puts "Поезд неправильный. Попробуйте другой"
    else
      @trains[@number] = @type
      puts "Поезд с номером #{@number} и типом #{@type} принят на станцию"
    end
  end

  def trains_list #Список всех поездов на станции
    puts "Поезда на станции: \n #{@trains} "
  end

  def trains_list_type #Список всех поездов на станции по типу (грузовой/пассажирский)
    puts "На станции поездов типа Cargo (Грузовых): #{count_hash(@trains, "cargo")}"
    puts "На станции поездов типа Passenger (Пассажирских): #{count_hash(@trains, "passenger")}"
  end

  def train_depart(train = {}) #Отправить поезд
    @number = train.keys.join
    @type   = train.values.join
    if @trains.include?({@number => @type})
      @trains.delete({@number => @type})
      puts "Поезд Номер: #{@number} покинул станцию"
    else
      puts "На станции нет такого поезда"
    end
  end
end

# Маршруты
class Route
  attr_accessor :route

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @route = [@first_station, @last_station]
    puts "Маршрут #{@first_station} - #{@last_station} создан"
  end

  def add(station) #Добавить промежуточную станцию
    @route.insert(1, station)
    puts "Новая станция (#{station}) добавлена в маршрут"
  end

  def delete(station) #Удалить промеждуточную станцию

    if station != @first_station || station != @last_station
      if @route.include?(station)
        @route.delete(station)
        puts "Станция #{station} удалена из маршрута"
      else
        puts "Станции #{station} нет в маршруте"
      end
    else
      puts "Станцию #{station} нельзя удалить"
    end
  end

  def route_list #Список всех станций
    puts "Маршрут от #{@first_station} до #{@last_station}"
    @route.each_with_index{ |station, index| puts "#{index + 1}. #{station}"}
  end
end

#Поезда ( :cargo грузовой, :passenger пассажирский)
class Train
  attr_reader :speed, :wagon, :type, :route, :station

  def initialize(number, type, wagons)
    @number = number.to_s
    @type = type
    @train = {number => @type}
    @speed = 0
    @wagons = wagons
    puts "Создан новый поезд №#{@number}, типа #{@type}"
  end

  def speed_up #Набирать скорость
    @speed += 20
    if speed_zero?
      puts "Поезд №#{@number} сдвинулся с места и поехал со скоростью 20 км/ч"
    else
      puts "Поезд №#{@number} ускорился на 20 км/ч, теперь его скорость составляет #{@speed}"
    end
  end

  def speed #Текущая скорость
    puts puts "Поезд №#{@number} имеет скорость #{@speed}"
  end

  def stop #Тормозить (сбрасывать скорость до нуля)
    if speed_zero?
      puts "Поезд №#{@number} уже стоит"
    else
      @speed = 0
      puts "Поезд №#{@number} остановлен"
    end
  end

  def wagons_count #Количество вагонов
    puts "Поезд №#{@number} имеет количество вагонов: #{@wagons}"
  end

  def add_wagon #Прицепить вагон
    if speed_zero?
      @wagons += 1
      puts "Поезду №#{@number} добавлен новый вагон, теперь у него вагонов #{@wagons} шт."
    else
      puts "Остановите поезд"
    end
  end

  def delete_wagon #Отцепить вагон (проверки на нулевое и отрицательное количество вагонов нет в ТЗ )
    if speed_zero?
      @wagons -= 1
      puts "От поезда №#{@number} отцеплен вагон, теперь у него вагонов #{@wagons} шт."
    else
      puts "Остановите поезд"
    end
  end

  def take_route(route) #Принять маршрут следования
    @route = route.route_list
    @station_index = 0
    @current_station = route.route_list.first

    puts "Поезд № #{@number} принят на станции #{@route.first}"
  end

  def go_next_station #Вперёд на одну станцию
    if @station_index < @route.length - 1
      @station_index += 1
      puts "Поезд перемещён на одну станцию вперёд"
    else
      puts "Вперёд нельзя, вы на конечной станции маршрута"
    end
  end

  def go_prev_station #Назад на одну станцию
    if @station_index > 0
      @station_index -= 1
      puts "Поезд перемещён на одну станцию назад"
    else
      puts "Назад нельзя, вы на первой станции маршрута"
    end

  end

  def current_station
    puts "Текущая станция: #{@route[@station_index]}."
  end

  def prev_station
    puts "Предыдущая станция: #{@route[@station_index - 1]}."
  end

  def next_station
    puts "Следующая станция: #{@route[@station_index + 1]}."
  end


  private

  def speed_zero?
    @speed.zero?
  end

  def count_hash(hash, value)
    count = 0
    hash.values.each do |t|
      if t == value
        count += 1
      end
    end
    count
  end
end



