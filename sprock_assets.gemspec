lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sprock_assets/version'

Gem::Specification.new do |gem|
  gem.name          = 'sprock-assets'
  gem.date          = '2012-09-24'
  gem.version       = SprockAssets::VERSION
  gem.authors       = ['Nick Barth']
  gem.email         = ['nick@nickbarth.ca']
  gem.summary       = 'A Ruby Gem for compiling assets through Sprock.'
  gem.description   = 'SprockAssets is a Rack Middleware you can include in your application for compiling your assets on the fly with Sprockets.'
  gem.homepage      = 'https://github.com/nickbarth/SprockAssets'
  s.executables     = ['sprock-assets']

  gem.add_dependency('sprockets')
  gem.add_development_dependency('rake')
  gem.add_development_dependency('rack')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('capybara')

  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep /spec/
  gem.require_paths = ['lib']
end
