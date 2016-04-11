require 'httparty'
require 'sentimentalizer'
require 'yt'
# require 'semantria'

Sentimentalizer.setup

module YtNlp
  class Sentiment
    include HTTParty

    class << self
      def analyze_and_report video_id, size, type, debug=false
        results = new({debug: debug}).analyze(video_id, size, type)
        YtNlp::Report.generate_sentiment_report(video_id, size, type, results)
      end
    end

    def initialize(options={})
      @debug = options.fetch :debug, false
    end

    def analyze video_id, size=1000, type=:top_comment
      comments = fetch_comments(video_id, size, type)
      comments.map do |text|
        h, debug_info = analyze_each(text)
        h[:text] = text
        h
      end
    end

    def fetch_comments(video_id, size, type)
      video = Yt::Video.new id: video_id
      video.comment_threads.take(size).map(&:text_display)
    end

    def analyze_each(text)
      result_1 = nil
      begin
        response_1 = HTTParty.post(
          'http://sentiment.vivekn.com/api/text/',
          body: { txt: text },
          headers: {
            "Accept" => "application/json"
          },
          timeout: 3
        )

        result_1 = normalize_response JSON.parse(response_1.body)
      rescue Timeout::Error, HTTParty::ResponseError
      end

      result_2 = nil
      begin
        response_2 = HTTParty.post(
          "https://twinword-sentiment-analysis.p.mashape.com/analyze/",
          query: { text: text },
          headers:{
            "X-Mashape-Key" => "DTftmgx6mqmshzoDzqDiiUGBpcsvp1VugBPjsn7LEA5WjpT1jp",
            "Content-Type" => "application/x-www-form-urlencoded",
            "Accept" => "application/json"
          },
          timeout: 3
        )
        result_2 = normalize_response JSON.parse(response_2.body)
      rescue Timeout::Error, HTTParty::ResponseError
      end

      result_3 = normalize_response Sentimentalizer.analyze(text)

      # TODO: result_4
      # client = Semantria::Client.new '06f7212b-7e12-4f1b-a040-f4fc732c4acc', '911e4915-9058-47e2-b106-df51b94f413b'
      # client.queue_document(comments)
      # client.get_processed_documents
      result_set = [result_1, result_2, result_3].compact
      vote(result_set).tap do |r|
        r[:debug] = result_set if @debug
      end
    end

    def vote results
      candidates = results.group_by { |r| r[:sentiment] }.values.max_by(&:size)
      if candidates.length > 1
        candidates.max_by { |c| c[:probability] }.clone
      else
        candidates.first.clone
      end
    end

    def normalize_response resp
      if resp.is_a? ClassificationResult
        {}.tap do |h|
          h[:sentiment] = to_label(resp.sentiment)
          h[:probability] = resp.overall_probability.to_f
        end
      elsif resp['result']
        {}.tap do |h|
          r = resp['result']
          h[:sentiment] = to_label(r['sentiment'])
          h[:probability] = r['confidence'].to_f / 100
        end
      elsif resp['author'] == 'twinword inc.'
        {
          sentiment: to_label(resp['type']),
          probability: 0.0
        }
      end
    end

    def to_label str
      case str.downcase
      when ':)', 'positive'
        :positive
      when ':|', 'neutral'
        :neutral
      when ':(', 'negative'
        :negative
      else
        str
      end
    end
  end
end
