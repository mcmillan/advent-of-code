class PasswordRequirement
  attr_reader :first_position, :second_position, :character, :input

  def initialize(definition)
    matches = /([0-9]+)-([0-9]+)\s+([a-z]+):\s+([A-Za-z]+)/.match(definition)

    @first_position = matches[1].to_i
    @second_position = matches[2].to_i
    @character = matches[3]
    @input = matches[4]
  end

  def first_position_valid?
    input[@first_position - 1] == character
  end

  def second_position_valid?
    input[@second_position - 1] == character
  end

  def valid?
    [first_position_valid?, second_position_valid?].select.one?
  end
end

puts File.read('input.txt').split("\n").map { |definition| PasswordRequirement.new(definition) }.select(&:valid?).count
