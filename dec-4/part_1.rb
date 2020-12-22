class Passport
  REQUIRED_FIELDS = %w[
    byr
    iyr
    eyr
    hgt
    hcl
    ecl
    pid
  ].freeze

  attr_accessor(*REQUIRED_FIELDS)

  def initialize(line)
    tokens = line.split(/\s/).reject(&:empty?)
    @values = {}

    tokens.each do |token|
      key, value = token.split(':')
      @values[key] = value
    end
  end

  def valid?
    REQUIRED_FIELDS.all? do |key|
      !@values[key].nil?
    end
  end
end

puts File.read('input.txt').split("\n\n").map { |line| Passport.new(line) }.select(&:valid?).count
