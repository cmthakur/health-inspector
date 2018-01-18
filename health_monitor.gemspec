
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'health_monitor/version'
require 'health_monitor/service_loader'

Gem::Specification.new do |spec|
  spec.name          = 'health_monitor'
  spec.version       = HealthMonitor::VERSION
  spec.authors       = ['cmthakur']
  spec.email         = ['chandra.thakur@cloudfactory.com']

  spec.summary       = 'A Ruby library which which provides a health checking and monitoring of various services associated with given application.'
  spec.description   = 'A Ruby library which which provides a health checking and monitoring of various services associated with given application.'
  spec.homepage      = 'https://github.com/cmthakur/health_monitor'
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

  # Add dependent gems listed in monitor.yml file
  ServiceLoader.new.dependencies.each do |dependency|
    spec.add_dependency dependency
  end
end
