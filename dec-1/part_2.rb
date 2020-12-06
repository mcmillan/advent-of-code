expenses = File.read('input.txt').split("\n").map(&:to_i)

expenses.each do |expense|
  (expenses - [expense]).each do |other_expense|
    (expenses - [expense] - [other_expense]).each do |other_other_expense|
      next unless expense + other_expense + other_other_expense == 2020

      puts expense * other_expense * other_other_expense
      exit
    end
  end
end
