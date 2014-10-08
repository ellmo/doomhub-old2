module SlugUrlNameChecker
  extend ActiveSupport::Concern

  def generate_default_url_name
    self.url_name = name
    self.send :set_slug
  end

  def trim_spaces
    self.name = name.strip.gsub(/\s+/, ' ')
    self.url_name = url_name.strip.gsub(/\s+/, ' ') if url_name
  end
end