# Прямоугольный треугольник

puts 'Введите сторону A'
a = gets.to_i
puts 'Введите сторону B'
b = gets.to_i
puts 'Введите сторону C'
c = gets.to_i

if a >= b && a > c
  hypotenuse = a
  firstCathetus = b
  secondCathetus = c
elsif b > a && b > c
  hypotenuse = b
  firstCathetus = a
  secondCathetus = c
elsif c > b && c >= a
  hypotenuse = c
  firstCathetus = a
  secondCathetus = b
end

if a == b && a == c
  puts 'Треугольник равносторонний'
elsif hypotenuse**2 == (firstCathetus**2 + secondCathetus**2)
  puts 'Треугольник прямоугольный'
elsif a == b || a == c || b == c
  puts 'Треугольник равнобедренный'
else
  puts 'Треугольник херня'
end