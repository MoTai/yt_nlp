require 'spec_helper'

describe 'configuration' do
  subject(:yt_config) { YtNlp.config }

  it 'should be same as Yt:Configuration' do
    expect(yt_config).to be_a Yt::Configuration
  end
end
