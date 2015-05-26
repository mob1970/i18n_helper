require 'spec_helper'

RSpec.describe Utils::FileUtils do
  context 'home directory' do
    let(:expected) { File.expand_path('~') }

    it "return user's home directory" do
      expect(Utils::FileUtils::home_directory).to eq(expected)
    end
  end
end
