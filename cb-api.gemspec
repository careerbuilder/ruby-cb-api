$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cb/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cb-api'
  s.version     = Cb::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Jesse Retchko', 'Chris Little', 'Matthew Moldavan', 'Miriam Williams', 'David Posey', 'Kyle Bumpus', 'Jon Molinaro', 'Ben Schmaltz', 'Raul Gil', 'Christina Chatham', 'Alex Hristov']
  s.email       = ['Jesse.Retchko@Careerbuilder.com', 'Chris.Little@Careerbuilder.com', 'Matt.Moldavan@Careerbuilder.com', 'Jon.Molinaro@careerbuilder.com', 'MiriamDeana@gmail.com', 'David.Posey@Careerbuilder.com', 'Kyle.Bumpus@Careerbuilder.com', 'Ben.Schmaltz@Careerbuilder.com', 'Raul.Gil@Careerbuilder.com', 'Christina.Chatham@Careerbuilder.com', 'Alex.Hristov@Careerbuilder.com']
  s.homepage    = 'http://api.careerbuilder.com'
  s.summary     = 'Ruby wrapper around Careerbuilder Public API.'
  s.description = 'Ruby wrapper for Careerbuilder Public API.'
  s.license     = 'MIT'

  s.files        = Dir['{lib}/**/*.rb', 'LICENSE', '*.md']
  s.require_path = 'lib'

  s.add_dependency 'httparty', '~> 0.11.0'
  s.add_dependency 'json', '~> 1.7.7'
  s.add_dependency 'nori', '~> 2.2.0'
  s.add_dependency 'nokogiri', '~> 1.6.0'
  s.add_dependency 'activesupport', '~> 4.0.0'
  s.add_dependency 'webmock', '~> 1.9.0'
  s.add_dependency 'simplecov', '>= 0.7.1'
  s.add_dependency 'rake', '>= 0.8.7'
  s.add_dependency 'rspec', '>= 2.11'
  s.add_dependency 'dotenv', '~> 0.9.0'
end
