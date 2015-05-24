require 'spec_helper'

RSpec.describe DatabaseHandler do

  describe 'database access types' do
    context 'checking if table exists' do
      it 'returns table exists when it exists' do
        allow(File).to receive(:expand_path).and_return("#{File.expand_path('.')}/spec/db")
        expect(DatabaseHandler.table_exists?('project_with_table')).to be(true)
      end

      it 'returns table does not exist when it does not exist' do
        allow(File).to receive(:expand_path).and_return("#{File.expand_path('.')}/spec/db")
        expect(DatabaseHandler.table_exists?('project_without_table')).to be(false)
      end
    end

    context 'create table in database' do
      it 'creates the table if it does not exists'
      it 'does not create the table if it exists'
    end

    context 'insert translation in database' do
      it 'inserts information in table'
    end

    context 'select information in database' do
      it 'retrieves information querying by key'
      it 'retrieves information querying by value'
    end

    context 'delete information in database' do
      it 'delete the information'
    end

  end
end
