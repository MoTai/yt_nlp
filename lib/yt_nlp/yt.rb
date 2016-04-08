require 'yt'

module YtNlp
  def self.configuration
    Yt.configuration
  end

  def self.config
    yield Yt.configuration
  end
end
