class RomanNumeralConverter
  ROMAN_NUMERALS = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
  DECIMAL_VALUES = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]

  def to_roman_numeral(number)
    result = ''
    remaining = number.to_i

    ROMAN_NUMERALS.each_with_index do |roman_numeral, i|
      decimal_value = DECIMAL_VALUES[i]
      while remaining >= decimal_value
        result += roman_numeral
        remaining -= decimal_value
      end
    end

    result
  end

  def from_roman_numeral(roman_numeral)
    result = 0
    input = roman_numeral.upcase

    ROMAN_NUMERALS.each_with_index do |roman_numeral_to_check, i|
      decimal_value = DECIMAL_VALUES[i]
      while input.start_with?(roman_numeral_to_check)
        result += decimal_value
        input = input.slice(roman_numeral_to_check.length, input.length)
      end
    end

    result
  end
end