class Route
  attr_reader :name, :route

  def initialize(name, first_station, last_station)
    @name = name
    @route = [first_station, last_station]
  end

  def add(station) # Добавить новую станцию предпоследней
    @route.insert(-2, station)
  end

  def delete(station) # Удалить станцию из маршрута
    @route.delete(station)
  end

  def route_list # Вывод списка всех станций на маршруте. Для получения маршрута использовать геттер route
    @route.each_with_index{ |station, index| puts "#{index + 1}. #{station}"}
  end
end