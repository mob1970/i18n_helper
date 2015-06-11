require 'spec_helper'

RSpec.describe ParametersHandler do

  describe '#parse' do

    context 'getting -p parameter' do

      let(:parameters) { ['-p', 'demo'] }
      let(:parameter) { Parameter.new(:project, 'demo') }

      it 'fetch -p parameter' do
        parsed_parameters = ParametersHandler.extract(parameters)
        expect(parsed_parameters.first.name).to eq(parameter.name)
        expect(parsed_parameters.first.value).to eq(parameter.value)
      end
    end

    context 'getting --project parameter' do

      let(:parameters) { ['--project=demo'] }
      let(:parameter) { Parameter.new(:project, 'demo') }

      it 'fetch --project parameter' do
        parsed_parameters = ParametersHandler.extract(parameters)
        expect(parsed_parameters.first.name).to eq(parameter.name)
        expect(parsed_parameters.first.value).to eq(parameter.value)
      end
    end

    context 'getting -r parameter' do

      let(:parameters) { ['-r'] }
      let(:parameter) { Parameter.new(:refresh_cache, '') }

      it 'fetch -r parameter' do
        parsed_parameters = ParametersHandler.extract(parameters)
        expect(parsed_parameters.first.name).to eq(parameter.name)
        expect(parsed_parameters.first.value).to eq(parameter.value)
      end
    end

    context 'getting --refresh-cache parameter' do

      let(:parameters) { ['--refresh-cache'] }
      let(:parameter) { Parameter.new(:refresh_cache, '') }

      it 'fetch --refresh-cache parameter' do
        parsed_parameters = ParametersHandler.extract(parameters)
        expect(parsed_parameters.first.name).to eq(parameter.name)
        expect(parsed_parameters.first.value).to eq(parameter.value)
      end
    end

    context 'getting -q parameter' do

      let(:parameters) { ['-q', "value = 'Hello world'"] }
      let(:parameter) { Parameter.new(:query, "value = 'Hello world'") }

      it 'fetch --refresh-cache parameter' do
        parsed_parameters = ParametersHandler.extract(parameters)
        expect(parsed_parameters.first.name).to eq(parameter.name)
        expect(parsed_parameters.first.value).to eq(parameter.value)
      end
    end


    context 'getting --query parameter' do

      let(:parameters) { ['--query=value = \'Hello world\''] }
      let(:parameter) { Parameter.new(:query, "value = 'Hello world'") }

      it 'fetch --refresh-cache parameter' do
        parsed_parameters = ParametersHandler.extract(parameters)
        expect(parsed_parameters.first.name).to eq(parameter.name)
        expect(parsed_parameters.first.value).to eq(parameter.value)
      end
    end
  end
end

