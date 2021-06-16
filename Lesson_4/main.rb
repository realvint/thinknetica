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
    @wagons = []
  end

  def start
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
    else
      puts "Программа завершена"
      exit
    end
  end

  def create_station
    puts "Действие 1!"
    start
  end
  def create_train
    puts "Действие 2!"
    start
  end
  def create_route
    puts "Действие 3!"
    start
  end
  def add_station_to_route
    puts "Действие 4!"
    start
  end
  def remove_station_from_route
    puts "Действие 4!"
    start
  end
  def get_route_to_train
    puts "Действие 6!"
    start
  end
  def add_wagon_to_train
    puts "Действие 7!"
    start
  end
  def remove_wagon_from_train
    puts "Действие 8!"
    start
  end
  def move_train_on_route
    puts "Действие 9!"
    start
  end
  def show_stations_list
    puts "Действие 10!"
    start
  end
  def show_trains_on_station
    puts "Действие 11!"
    start
  end
end

main = Main.new
main.start


