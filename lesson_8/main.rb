require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'cargo_wagon'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'passenger_train'

class Main

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def start
    loop do
      puts " Управление железнодорожным вокзалом:
      [1] Создать станцию введите '1'
      [2] Создать поезд  введите '2'
      [3] Создать маршрут введите '3'
      [4] Добавить станцию к маршруту введите '4'
      [5] Удалить станцию из маршрута введите '5'
      [6] Назначить маршрут поезду введите '6'
      [7] Добавить вагон поезду введите '7'
      [8] Отцепить вагон от поезда введите '8'
      [9] Переместить поезд по маршруту введите '9'
      [10] Просмотреть список станций введите '10'
      [11] Просмотреть список поездов на станции введите '11'
      [12] Просмотреть список вагонов у поезда введите '12'
      [13] Занять место/объем в вагоне введите '13'
      [0] Чтобы выйти из программы введите '0' "
      input = gets.chomp.to_i

      case input
      when 0 then
        puts "Программа завершена"
        exit
      when 1 then create_station
      when 2 then create_train
      when 3 then create_route
      when 4 then add_station_to_route
      when 5 then remove_station_from_route
      when 6 then get_route_to_train
      when 7 then add_wagon_to_train
      when 8 then remove_wagon_from_train
      when 9 then move_train_on_route
      when 10 then show_stations_list
      when 11 then show_trains_on_station
      when 12 then show_wagons_at_train
      when 13 then take_unit_on_wagon
      else
        puts "Программа завершена"
        exit
      end
    end
  end

  private # Это служебные методы для управления всей системой, они не должны быть доступны вне класса

  def create_station
    begin
      puts "Введите название для станции"
      name = gets.chomp
      @stations << Station.new(name)
      puts "Станция #{name} создана"
    rescue Exception => e
      puts e.message
    end
  end

  def create_train
    begin
      puts "Введите номер для нового поезда"
      number = gets.chomp
      puts "Введите [passenger] для создания пассажирского поезда"
      puts "Введите [cargo] для создание грузового поезда"
      type = gets.chomp
      @trains << PassengerTrain.new(number,type) if type == 'passenger'
      @trains << CargoTrain.new(number,type) if type == 'cargo'
      puts "Поезд c номером #{number} типа #{type} создан"
    rescue Exception => e
      puts e.message
      retry
    end
  end

  def create_route
    begin
      puts "Введите название для нового маршрута:"
      name = gets.chomp
      puts "Введите название начальной станции:"
      first = gets.chomp
      first_station = find_station(first)
      puts "Введите название конечной станции:"
      last = gets.chomp
      last_station = find_station(last)
      @routes << Route.new(name, first_station, last_station)
      puts "Маршрут #{name} создан"
    rescue Exception => e
      puts e.message
    end
  end

  def add_station_to_route
    puts "Введите название маршрута для добавления станции "
    name = gets.chomp
    route = find_route(name)
    puts "Введите название станции для добавления "
    new_station = gets.chomp
    station = find_station(new_station)
    route.add(station)
    puts 'Станция добавлена в маршрут'
  end

  def remove_station_from_route
    puts "Введите название маршрута для удаления станции "
    name_route = gets.chomp
    puts "Введите название станции для удаления"
    name_station = gets.chomp
    station = find_station(name_station)
    route = find_route(name_route)
    route.delete(station)
    puts 'Станция удалена из маршрута'
  end

  def get_route_to_train
    puts "Введите маршрут"
    name = gets.chomp
    route = find_route(name)
    puts "Введите номер поезда для отправления по маршруту"
    number = gets.chomp
    train = find_train(number)
    train.take_route(route)
    puts "Поезд поставлен на маршрут"
  end

  def add_wagon_to_train # мы не можем добавить к поезду тип вагона, отличный от типа поезда
    puts "Введите номер поезда для добавления вагона"
    number = gets.chomp
    train = find_train(number)
    #по типу поезда строить запрос на количество мест/ объем
      if train.type == 'cargo'
        puts("Введите общий объём вместимого груза:")
        unit_quantity = gets.chomp
        train.add_wagon(CargoWagon.new(unit_quantity))
      else
        puts("Введите количество пассажирских мест:")
        unit_quantity = gets.chomp
        train.add_wagon(PassengerWagon.new(unit_quantity))
      end
    puts 'Вагон добавлен к поезду'
  end

  def remove_wagon_from_train
    puts "Введите номер поезда для удаления вагона"
    number = gets.chomp
    train = find_train(number)
    train.delete_wagon
    puts 'Вагон отцеплен от поезда'
  end

  def show_wagons_at_train # Выводим список вагонов у поезда
    puts "Введите номер поезда для просмотра вагонов"
    number_of_train = gets.chomp
    train = find_train(number_of_train)
    train.wagons_each { |wagon| puts wagon}
  end

  def take_unit_on_wagon # Занять место/объём в вагоне
    puts "Введите номер поезда для просмотра вагонов"
    number_of_train = gets.chomp
    train = find_train(number_of_train)
    puts "Введите номер вагона"
    number_of_wagon = gets.chomp
    wagon = find_wagon(train, number_of_wagon)
    if wagon.type == 'cargo'
      puts 'Введите объем, который нужно занять'
      quantity = gets.chomp.to_i
      wagon.take_unit(quantity)
      puts 'Погрузка успешна'
    else
      wagon.take_unit
      puts 'Место успешно занято'
    end
  end

  def move_train_on_route
    puts " Введите номер поезда для перемещения по маршруту"
    number = gets.chomp
    train = find_train(number)
    puts " Введите [1] для перемещения вперед по маршруту
           Введите [2] для перемещения назад по маршруту"
    input = gets.chomp
    train.go_next_station if input == 1
    train.go_prev_station if input == 2
    puts 'Поезд перемещён по маршруту'
  end

  def show_stations_list
    @stations.each { |station| puts station.name }

  end

  def show_trains_on_station
    puts " Введите название станции для просмотра доступных поездов"
    name = gets.chomp
    station = find_station(name)
    station.trains_each {|train| puts train}
  end

  def find_train(number)
    @trains.find { |train| train.number == number }
  end

  def find_route(name)
    @routes.find { |route| route.name == name }
  end

  def find_station(name)
    @stations.find { |station| station.name == name }
  end

  def find_wagon(train, number)
    train.wagons.find { |wagon| wagon.number == number }
  end
end

main = Main.new
main.start


