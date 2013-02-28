$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cb/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cb-api'
  s.version     = Cb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jesse Retchko']
  s.email       = ['Jesse.Retchko@Careerbuilder.com']
  s.homepage    = 'http://api.careerbuilder.com'
  s.summary     = 'Ruby wrapper around Careerbuilder Public API.'
  s.description = 'Ruby wrapper for Careerbuilder Public API.'

  s.files        = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  s.require_path = 'lib'

  s.add_dependency 'httparty', '>= 0.8.1'
  s.add_dependency 'json', '~> 1.7.6'
end