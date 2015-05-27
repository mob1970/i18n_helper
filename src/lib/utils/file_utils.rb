module Utils
  module FileUtils
    def self.home_directory()
      File.expand_path('~')
    end

    def self.file_exist?(file_path)
      File.exist?(file_path)
    end
  end
end
