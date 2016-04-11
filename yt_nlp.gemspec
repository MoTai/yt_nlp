lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'yt_nlp/version'

Gem::Specification.new do |spec|
  spec.name          = "yt_nlp"
  spec.version       = YtNlp::VERSION
  spec.authors       = ["Qiang han"]
  spec.email         = ["qiang.han@fullscreen.net"]
  spec.description   = %q{Topic extraction, sentiment analysis tool.}
  spec.summary       = %q{Text, opinion mining on youtube videos.}
  spec.homepage      = "http://github.com/MoTai/yt_nlp"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport'
  spec.add_dependency 'yt'
  spec.add_dependency 'httparty'
  # spec.add_dependency 'semantria'
  spec.add_dependency 'sentimentalizer', '>= 0.2.3'
  spec.add_dependency 'prawn'
  spec.add_dependency 'prawn-table'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'coveralls'
end
