$:.push File.expand_path('../lib', __FILE__)

require 'cb/version'

Gem::Specification.new do |s|
  s.name        = 'cb-api'
  s.version     = Cb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = 'The CareerBuilder.com Niche and Consumer Development teams'
  s.email       = 'ConsumerDevelopment@careerbuilder.com'
  s.homepage    = 'http://api.careerbuilder.com'
  s.summary     = 'Ruby wrapper around Careerbuilder Public API.'
  s.description = 'Ruby wrapper for Careerbuilder Public API.'
  s.license     = 'MIT'

  s.files        = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  s.require_path = 'lib'

  s.add_dependency 'httparty', '~> 0.11.0'
  s.add_dependency 'json', '~> 1.8.1'
  s.add_dependency 'nori', '~> 2.2.0'
  s.add_dependency 'xml-simple', '~> 1.1.3'

  s.add_development_dependency 'rake', '>= 0.8.7'
  s.add_development_dependency 'webmock', '~> 1.9.0'
  s.add_development_dependency 'simplecov', '>= 0.7.1'
  s.add_development_dependency 'rspec', '>= 2.11'
  s.add_development_dependency 'rdoc', '~> 3.12.2'
  s.add_development_dependency 'rspec-pride', '~> 2.2.0'
  s.add_development_dependency 'pry', '0.9.12.1'
  s.add_development_dependency 'rb-readline', '~> 0.5.0'
end
