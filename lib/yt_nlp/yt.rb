require 'yt'

module YtNlp
  def self.config
    conf = ::Yt::Configuration.new
    yield conf if block_given?
    conf
  end
end
