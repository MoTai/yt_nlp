require 'simplecov'
require 'coveralls'

require 'yt_nlp'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]
SimpleCov.start

Dir['./spec/support/**/*.rb'].each {|f| require f}

RSpec.configure do |config|
  config.order = 'random'
  config.run_all_when_everything_filtered = false

  config.before :all do
    YtNlp.config do |config|
      config.api_key = ENV['YT_TEST_SERVER_API_KEY']
      config.log_level = ENV['YT_LOG_LEVEL']
    end
  end
end
