lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbdo/version'

Gem::Specification.new do |spec|
  spec.name = 'rbdo'
  spec.version = RBDO::VERSION
  spec.authors = ['personinblack']
  spec.email = 'berkay@tuta.io'

  spec.summary = 'a simple todo app in cli'
  spec.homepage = 'https://github.com/personinblack/rbdo'
  spec.license = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.2'
  spec.add_runtime_dependency 'pastel', '~> 0.7.2'
  spec.add_development_dependency 'bundler', '~> 1.17'
end
