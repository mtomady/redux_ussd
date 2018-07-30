
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redux_ussd/version'

Gem::Specification.new do |spec|
  spec.name          = 'redux_ussd'
  spec.version       = ReduxUssd::VERSION
  spec.authors       = ['Niklas Riekenbrauck']
  spec.email         = ['nikriek@gmail.com']

  spec.summary       = 'DSL for building USSD menus using Redux pattern'
  spec.description   = 'DSL for building USSD menus using Redux pattern'
  spec.homepage      = 'https://github.com/DoctorsForMadagascar/redux_ussd'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49.0'
  spec.add_development_dependency 'coveralls', '~> 0.8.22'
end
