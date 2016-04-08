require 'spec_helper'

describe 'configuration' do
  specify {
    key = 'abc123xyz'
    YtNlp.configuration.api_key = key
    expect(Yt.configuration.api_key).to eq key
  }

  specify {
    log_level = 'xyz'
    YtNlp.config do |config|
      config.log_level = log_level
    end

    expect(Yt.configuration.log_level).to eq log_level
  }
end
