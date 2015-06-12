require 'spec_helper'

RSpec.describe Utils::FileUtils do
  context 'home directory' do
    let(:expected) { File.expand_path('~') }

    it "return user's home directory" do
      expect(Utils::FileUtils.home_directory).to eq(expected)
    end
  end

  context 'file_exists' do
    it 'returns true if file exists' do
      expect(Utils::FileUtils.file_exist?('./spec/files/existent_file.txt')).to eq(true)
    end

    it 'returns false if file exists'  do
      expect(Utils::FileUtils.file_exist?('./spec/files/non_existent_file.txt')).to eq(false)
    end
  end
end
