# frozen_string_literal:true

# Useful functions extending Integer class
class Integer
  def delimited
    # Adds comma's every 3 numbers, if possible, for Integer and return as String
    to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end
