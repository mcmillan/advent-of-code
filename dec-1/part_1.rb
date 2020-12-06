expenses = File.read('input.txt').split("\n").map(&:to_i)

expenses.each do |expense|
  other_expenses = expenses.reject { |e| e == expense }
  other_expenses.each do |other_expense|
    next unless expense + other_expense == 2020

    puts expense * other_expense
    exit
  end
end
