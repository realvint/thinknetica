# Задание 6.  Сумма покупок

basket = {}
sum = 0
total_cost = 0

loop do
  puts 'Введите название товара или "стоп" для завершения'
  product = gets.chomp
  break if product.downcase == 'стоп'

  puts 'Введите цену'
  cost = gets.chomp.to_f

  puts 'Введите количество'
  quantity = gets.chomp.to_f

  sum = cost * quantity
  basket[product]  = { cost => quantity }
  total_cost += sum

  puts "Итоговая сумма за текущий товар = #{sum}"
  puts "Товары в корзине: #{basket}"
  puts "Итоговая сумма всех покупок в корзине: #{total_cost}"
end