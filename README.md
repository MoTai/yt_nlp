# yt_nlp

NLP library for YouTube comments, etc.

### Usage

```ruby
YtNlp.config do |config|
  config.api_key = 'youtube_data_api_key'
end

result = YtNlp::Sentiment.analyze('MsplPPW7tFo', 1000, :top_comments)
```

### Tests

The tests will hit real youtube data API, make sure you have registered for an API key.

To run tests:

```
YT_LOG_LEVEL=debug YT_TEST_SERVER_API_KEY=youtube_data_api_key rspec -b
```
