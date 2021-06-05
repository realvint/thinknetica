# Площадь треугольника

puts 'Введите основание <a>'
a = gets.chomp.to_f
puts 'Введите высоту <h>'
h = gets.chomp.to_f

if a <= 0 || h <= 0
  puts 'Введенные данные не корректны'
else
  area = 1/2.to_f * a * h
  puts "Площадь треугольника равна #{area} у.е."
end