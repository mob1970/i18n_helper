module Utils
  module FileUtils
    def self.home_directory
      "#{File.expand_path('~')}/.i18n_helper/"
    end

    def self.file_exist?(file_path)
      File.exist?(file_path)
    end

    def self.create_home_directory
      Dir.mkdir(home_directory)
    end
  end
end
