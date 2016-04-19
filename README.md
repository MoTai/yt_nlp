# yt_nlp

NLP library for YouTube comments, etc.

### Features

Sentiment Analysis on YouTube video comments.

### Usage

```ruby
YtNlp.config do |config|
  config.api_key = 'youtube_api_key'
end

# results in ruby hash
result = YtNlp::Sentiment.analyze('MsplPPW7tFo', 1000, :top_comments)

# results in PDF format
pdf_str = YtNlp::Sentiment.analyze_and_report('MsplPPW7tFo', 1000, :top_comments)
File.open('report.pdf', 'w') { |f| f.write pdf_str }
```

### Tests

The tests will hit real youtube data API, make sure you have registered for an API key.

To run tests:

```shell
YT_LOG_LEVEL=debug YT_TEST_SERVER_API_KEY=youtube_data_api_key rspec -b
```
