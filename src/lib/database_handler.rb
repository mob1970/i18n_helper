require 'sqlite3'

class DatabaseHandler

  # create table translations(locale text(25), key text(255), value text(3000), PRIMARY KEY(locale, key));
  TRANSLATIONS_TABLE_NAME = 'translations'

  def self.table_exists?(project)
    count = connection(project).get_first_value( "SELECT count(*) FROM sqlite_master WHERE type='table' AND name='#{TRANSLATIONS_TABLE_NAME}'")
    count > 0
  end

  private

  def self.connection(project)
    SQLite3::Database.new("#{home_directory}/#{project}.db")
  end

  def self.home_directory()
    File.expand_path('~')
  end
end
