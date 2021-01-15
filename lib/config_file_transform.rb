# frozen_string_literal: true

# This utility class will load a config file at a specified path
# and create a hash based on key value pairs found within the file
#
# The default delimeter will be '=', but an alternate may be specified on initialization
#
# NOTE:
# if multiple values are specified for the same key, the last value assigned will override the previous values
# lines starting with '#', ';' will be ignored as comments
# lines which do not match the key delimeter value syntax will be ignored as erroneous
# lines which contain multiple delimeters will split on the first delimeter found
# if the file is not readable or contains no valid key / value pairs, an empty hash will be returned
class ConfigFileTransform
  BOOLEAN_TRUE_VALUES = %w[t true yes on].freeze
  BOOLEAN_FALSE_VALUES = %w[f false no off].freeze

  def initialize(file_path, delimeter = '=')
    @file_path = file_path
    @delimeter = delimeter
  end

  def to_hash
    return {} unless valid_file?

    result = {}
    open(@file_path) do |f|
      f.each do |line|
        import_line(line, result)
      end
    end
    result
  end

  private

  def valid_file?
    File.exist?(@file_path) && File.readable?(@file_path)
  end

  def import_line(line, result)
    line.strip!
    return if skip?(line)
    add_to_hash(line, result)
  end

  def add_to_hash(line, result)
    parts = line.split(@delimeter)
    key = parts[0].strip.to_sym
    if parts.size == 2
      value = get_value(parts[1].strip)
    else
      value = get_value(parts.drop(1).join(@delimeter).strip)
    end
    result[key] = value
  end

  def get_value(str)
    return str.to_f if float_val?(str)
    return str.to_i if int_val?(str)
    return true if true_val?(str)
    return false if false_val?(str)
    return str
  end

  # skip the line if it starts with a comment character '#' or does not contain a delimeter
  # or the delimeter is on the beginning or end of the line
  def skip?(line)
    line[0] == '#' || !line.include?(@delimeter) || line.split(@delimeter).size < 2
  end

  # these should be moved to a helper function or maybe be an extension of the String class
  def float_val?(val)
    !!(val =~ /\A[-+]?\d+(\.\d+)?\z/)
  end

  def int_val?(val)
    !!(val =~ /\A[-+]?[0-9]+\z/)
  end

  def true_val?(val)
    BOOLEAN_TRUE_VALUES.include?(val.downcase)
  end
  def false_val?(val)
    BOOLEAN_FALSE_VALUES.include?(val.downcase)
  end
end
