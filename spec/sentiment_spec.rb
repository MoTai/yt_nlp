require 'spec_helper'

describe YtNlp::Sentiment do
  context 'with debugging info' do
    subject(:sentiment) { YtNlp::Sentiment.new(debug: true) }

    it 'should analyze video comments' do
      video_id = 'MsplPPW7tFo'
      size = 1
      type = :top_comment
      results = sentiment.analyze(video_id, size, type)
      expect(results.first).to be_a Hash
      expect(results.first[:debug]).not_to be_nil
    end
  end

  context 'without debugging info' do
    subject(:sentiment) { YtNlp::Sentiment.new }

    it 'should analyze video comments' do
      video_id = 'MsplPPW7tFo'
      size = 1
      type = :top_comment
      results = sentiment.analyze(video_id, size, type)
      expect(results.first[:debug]).to be_nil
    end
  end

end
