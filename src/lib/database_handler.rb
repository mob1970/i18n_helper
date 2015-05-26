require 'sqlite3'

class DatabaseHandler

  # create table translations(locale text(25), key text(255), value text(3000), PRIMARY KEY(locale, key));
  TRANSLATIONS_TABLE_NAME = 'translations'

  def self.table_exists?(project)
    count = connection(project).get_first_value( "SELECT count(*) FROM sqlite_master WHERE type='table' AND name='#{TRANSLATIONS_TABLE_NAME}'")
    count > 0
  end

  def self.create_table(project)
    return if table_exists?(project)
    sentence = 'create table translations(locale text(25), key text(255), value text(3000), PRIMARY KEY(locale, key))'
    client = connection(project)
    client.execute(sentence)
    client.close
  end

  def self.insert(project, values)
    sentence = 'INSERT INTO translations(locale, key, value) VALUES(?, ?, ?)'
    client = connection(project)
    values.each do |item|
      client.execute(sentence, [item[:locale], item[:key], item[:value]])
    end
    client.close
  end

  def self.query_rows(project, conditions='')
    sentence = 'SELECT locale, key, value FROM translations '
    sentence += "WHERE #{conditions}" unless conditions.empty?
    result = []
    connection(project).execute(sentence).each do |row|
      result << {:locale => row[0], :key => row[1], :value => row[2]}
    end

    result
  end

  def self.delete(project, conditions='')
    sentence = 'DELETE FROM translations '
    sentence += "WHERE #{conditions}" unless conditions.empty?
    connection(project).execute(sentence)
  end

  private

  def self.connection(project)
    SQLite3::Database.new("#{Utils::FileUtils::home_directory}/#{project}.db")
  end
end
