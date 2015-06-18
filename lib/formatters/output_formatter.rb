class OutputFormatter
  def self.format(rows)
    result = ""

    unless rows.empty?
      sizes = preprocess_column_widths(rows)
      result += format_headers(rows, sizes)
      result += format_values(rows, sizes)
    end

    result
  end

  private

  def self.format_headers(rows, sizes)
    result = ''

    formatted_values = []
    rows.first.keys.each do |item|
      formatted_values << append_spaces_at_the_end(item.to_s, sizes[item])
    end
    result += "#{formatted_values.join(' | ')}\n"

    result
  end

  def self.format_values(rows, sizes)
    result = ''

    rows.each do |row|
      formatted_values = []
      row.keys.each do |key|
        formatted_values << append_spaces_at_the_end(row[key], sizes[key])
      end
      result += "#{formatted_values.join(' | ')}\n"
    end

    result + "\n"
  end

  def self.preprocess_column_widths(rows)
    result = {}
    rows.first.keys.each do |key|
      result[key] = self.calculate_max_value_length(rows, key)
    end

    result
  end

  def self.append_spaces_at_the_end(string, number)
    ((number - string.strip.length) > 0 ) ? string.strip  + (' ' * (number - string.strip.length)) : string.strip
  end

  def self.calculate_max_value_length(rows, key)
    result = 0
    rows.each do |row|
      result = row[key].strip.length if row[key].strip.length > result
    end

    (key.to_s.strip.length > result) ? key.to_s.strip.length : result
  end
end
