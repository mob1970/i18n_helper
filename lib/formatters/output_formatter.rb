class OutputFormatter
  def self.format(rows)
    result = ""

    sizes = preprocess_column_widths(rows)

    unless rows.empty?
      result += "#{rows.first.keys.join('|')}\n"
    end

    rows.each do |row|
      result += "#{row.values.join('|')}\n" unless row.empty?
    end

    result
  end

  private

  def preprocess_column_widths(rows)
    {
      :key => calculate_max_key_value_length(rows),
      :value => calculate_max_value_value_length(rows),
      :locale => calculate_max_locale_value_length(rows)
    }
  end

  def append_spaces_at_the_end(string, number)
    string  +(' '*number)
  end

  def calculate_max_key_value_length(rows)
    calculate_max_value_length(rows, :key)
  end

  def calculate_max_value_value_length(rows)
    calculate_max_value_length(rows, :value)
  end

  def calculate_max_locale_value_length(rows)
    calculate_max_value_length(rows, :locale)
  end

  def calculate_max_value_length(rows, key)
    result = 0
    rows.each do |row|
      result = row[key].strip.length if row[key].strip.length > result
    end

    result
  end
end
