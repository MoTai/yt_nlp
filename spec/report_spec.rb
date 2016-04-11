require 'spec_helper'

describe YtNlp::Report do
  subject(:report) { YtNlp::Report }
  it 'should generate reports' do
    data = [
      {
        text: "This is my dream car, nice video!",
        sentiment: :positive,
        probability: 0.9
      },
      {
        text: "i just won a Nigeria lottery, i'm gonna buy one",
        sentiment: :positive,
        probability: 0.9
      },
      {
        text: "wouldn't use this if I owned a tesla doesn't considering all of the softwares are over the air can't someone just hack Tesla and mess up everyone's system ?",
        sentiment: :positive,
        probability: 0.9
      },
      {
        text: "Reminds me of the car in the I, Robot movie.",
        sentiment: :positive,
        probability: 0.9
      },
      {
        text: "You had me at \"just downloaded a firmware update for my car\"\nHow awesome arent the times we live in?",
        sentiment: :negative,
        probability: 0.9
      },
      {
        text: "Naysayers will always have something stupid to say about Tesla. \"Oh it cant fly to the moon, crap car\", well, give it a couple of years, Tesla might do it just to piss you off",
        sentiment: :negative,
        probability: 0.9
      },
      {
        text: "Tesla beat Google.. Again!",
        sentiment: :neutral,
        probability: 0.9
      }
    ]

    pdf = report.generate_sentiment_report('abc123xyz', 1000, 'Top Comments', data)
    # File.open(File.expand_path('../tmp/test.pdf', __FILE__), 'w') do |f|
    #   f.write pdf
    # end
    expect(pdf).not_to be_empty
  end
end
