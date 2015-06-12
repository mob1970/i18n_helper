require 'spec_helper'

RSpec.describe MessageProcessor do
  before :each do
    @project = 'old_project'
  end

  describe 'message processing' do
    context 'when a project is set' do
      it 'must change de project to handle' do
        new_project_name = 'new_project'

        result = MessageProcessor::process(@project, "set project #{new_project_name}")
        expect(result.output).to eq(new_project_name)
      end
    end

    context 'refreshing project''s cache' do
      it 'must recognize it''s a refresh cache order' do
        allow(DatabaseHandler).to receive('delete').and_return(10)

        result = MessageProcessor::process(@project, 'refresh cache')
        expect(result.action).to eq(MessageProcessor::REFRESH_CACHE)
        expect(result.output).to be_nil
      end
    end

    context 'query something from the database' do
      it 'must recognize it''s a query order' do
        allow(DatabaseHandler).to receive('query_rows').and_return(10)

        result = MessageProcessor::process(@project, 'query something')
        expect(result.action).to eq(MessageProcessor::QUERY)
      end
    end

  end
end
