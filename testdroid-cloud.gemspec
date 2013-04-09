# -*- encoding: utf-8 -*-

require File.expand_path('../lib/testdroid-cloud/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "testdroid-cloud"
  gem.version       = Testdroid::VERSION
  gem.summary       = "Library for running builds in Testdroid Cloud"
  gem.description   = ""
  gem.license       = "MIT"
  gem.authors       = ["Sakari Rautiainen"]
  gem.email         = "sakari.rautiainen@bitbar.com"
  gem.homepage      = "https://rubygems.org/gems/testdroid_cloud"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']
  
  gem.add_dependency 'yard', '~> 0.8'
  gem.add_dependency 'rest-client', '~> 1.6.5'
  gem.add_dependency 'json', '~> 1.6.2'
  gem.add_development_dependency 'json', '~> 1.6.2'
  gem.add_development_dependency 'rspec', '~> 2.4'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
