require 'i18n'

class TranslationsProcessor
  attr_reader :translations

  def initialize(path_to_project, project)
    @project_path = File.join(path_to_project, project)
  end

  def extract_translations
    @translations = []
    I18n.load_path = collect_files(@project_path)

    I18n.backend.load_translations

    I18n.available_locales.each do |locale|
      store_locale(locale)
    end
  end

  private

  def collect_files(project_path)
    files = []
    Dir["#{project_path}/**/*.yml"].each do |item|
      files << item if item['locale']
    end

    files
  end

  def store_locale(locale)
    I18n.locale = locale
    I18n.backend.send(:translations)[locale].keys.each do |key|
      extract_key(key, locale)
    end
  end

  def extract_key(key, locale)
    if I18n.t(key).is_a? String
      unless I18n.t(key).start_with?('translation missing')
        @translations << { :key => key.to_s, :value => I18n.t(key).to_s, :locale => locale.to_s }
      end
      return
    end

    if I18n.t(key).is_a? Array
      I18n.t(key).each do |item|
        extract_key("#{key}.#{item}", locale) if item
      end
    end

    if I18n.t(key).is_a? Hash
      I18n.t(key).keys.each do |item|
        extract_key("#{key}.#{item}", locale) if item
      end
    end
  end

end
