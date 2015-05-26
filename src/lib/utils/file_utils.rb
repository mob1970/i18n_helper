module Utils
module FileUtils
  def home_directory()
    File.expand_path('~')
  end
end
end
