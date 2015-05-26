require 'spec_helper'

RSpec.describe DatabaseHandler do

  before :each do
    FileUtils.rm('./spec/db/project_with_table.db')
    FileUtils.cp('./spec/db/samples/empty_with_table.db', './spec/db/project_with_table.db')

    FileUtils.rm('./spec/db/project_without_table.db')
    FileUtils.cp('./spec/db/samples/empty_without_table.db', './spec/db/project_without_table.db')

    locale = 'en'
    key = 'test.text'
    value = 'This is the spec text'
  end

  describe 'database access types' do
    context 'checking if table exists' do
      it 'returns table exists when it exists' do
        allow(Utils::FileUtils).to receive(:home_directory).and_return("#{File.expand_path('.')}/spec/db")
        expect(DatabaseHandler.table_exists?('project_with_table')).to be(true)
      end

      it 'returns table does not exist when it does not exist' do
        allow(Utils::FileUtils).to receive(:home_directory).and_return("#{File.expand_path('.')}/spec/db")
        expect(DatabaseHandler.table_exists?('project_without_table')).to be(false)
      end
    end

    context 'create table in database' do
      it 'creates the table if it does not exists' do
        allow(Utils::FileUtils).to receive(:home_directory).and_return("#{File.expand_path('.')}/spec/db")
        expect(DatabaseHandler.table_exists?('project_without_table')).to be(false)
        DatabaseHandler.create_table('project_without_table')
        expect(DatabaseHandler.table_exists?('project_without_table')).to be(true)
      end
    end

    context 'insert translation in database' do
      let(:locale) { 'en' }
      let(:key) { 'message.text' }
      let(:value) { 'This is not a valid email.' }

      it 'inserts information in table' do
        allow(Utils::FileUtils).to receive(:home_directory).and_return("#{File.expand_path('.')}/spec/db")
        DatabaseHandler.insert('project_with_table', [{:locale => locale, :key => key, :value => value}])

        conditions = "locale = '#{locale}' AND key = '#{key}' AND value = '#{value}'"
        expected = {:locale => locale, :key => key, :value => value}

        row_exists?('project_with_table', conditions, expected)
      end
    end

    context 'select information in database' do
      let(:locale) { 'en'}
      let(:key) { 'test.text' }
      let(:value) { 'This is the spec text' }


      it 'retrieves information querying by key' do
        conditions = "locale = '#{locale}' AND key = '#{key}'"
        expected = {:locale => locale, :key => key, :value => value}

        row_exists?('project_with_table', conditions, expected)
      end

      it 'retrieves information querying by value' do
        conditions = "locale = '#{locale}' AND value = '#{value}'"
        expected = {:locale => locale, :key => key, :value => value}

        row_exists?('project_with_table', conditions, expected)
      end
    end

    context 'delete information in table translations' do
      it 'delete the information' do
        allow(Utils::FileUtils).to receive(:home_directory).and_return("#{File.expand_path('.')}/spec/db")
        DatabaseHandler.delete('project_with_table')
        result = DatabaseHandler.query_rows('project_with_table')

        expect(result.size).to eq(0)
      end
    end

  end
end
