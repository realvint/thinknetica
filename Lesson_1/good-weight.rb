# Идеальный вес

puts 'Введите ваше имя'
name = gets.chomp

puts "Приветствую #{name}, какой у вас рост? "
height = gets.chomp.to_i

weight = (height - 110)*1.15

if weight > 0
  puts "#{name}, ваш идеальный вес #{weight.round} кг."
else
  # мне кажется это неверный ответ (нужно запрашивать текущий вес у пользователя)
  puts "#{name}, ваш вес уже оптимальный"
end