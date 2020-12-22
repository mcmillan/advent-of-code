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
    required_fields_present? && valid_byr? && valid_iyr? && valid_eyr? && valid_hgt? && valid_hcl? && valid_ecl? && valid_pid?
  end

  def required_fields_present?
    REQUIRED_FIELDS.all? do |key|
      !@values[key].nil?
    end
  end

  def valid_byr?
    @values['byr'].to_i >= 1920 && @values['byr'].to_i <= 2002
  end

  def valid_iyr?
    @values['iyr'].to_i >= 2010 && @values['iyr'].to_i <= 2020
  end

  def valid_eyr?
    @values['eyr'].to_i >= 2020 && @values['eyr'].to_i <= 2030
  end

  def valid_hgt?
    return false unless @values['hgt'].end_with?('cm') || @values['hgt'].end_with?('in')

    type = @values['hgt'].end_with?('cm') ? :cm : :inches
    value = @values['hgt'].sub(/(cm|in)\z/, '').to_i

    type == :cm ? value >= 150 && value <= 193 : value >= 59 && value <= 76
  end

  def valid_hcl?
    @values['hcl'] =~ /^\#[a-f0-9]{6}$/
  end

  def valid_ecl?
    %w[amb blu brn gry grn hzl oth].include?(@values['ecl'])
  end

  def valid_pid?
    @values['pid'] =~ /^[0-9]{9}$/
  end
end

puts File.read('input.txt').split("\n\n").map { |line| Passport.new(line) }.select(&:valid?).count
