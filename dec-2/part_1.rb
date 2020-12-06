class PasswordRequirement
  attr_reader :min_occurrences, :max_occurrences, :character, :input

  def initialize(definition)
    matches = /([0-9]+)-([0-9]+)\s+([a-z]+):\s+([A-Za-z]+)/.match(definition)

    @min_occurrences = matches[1].to_i
    @max_occurrences = matches[2].to_i
    @character = matches[3]
    @input = matches[4]
  end

  def occurrences
    @occurrences ||= input.scan(character).count
  end

  def valid?
    occurrences >= min_occurrences && occurrences <= max_occurrences
  end
end

puts File.read('input.txt').split("\n").map { |definition| PasswordRequirement.new(definition) }.select(&:valid?).count
