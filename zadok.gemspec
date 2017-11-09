lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zadok/version'

Gem::Specification.new do |spec|
  spec.name          = 'zadok'
  spec.version       = Zadok::VERSION
  spec.date          = Time.now.strftime('%Y-%m-%d')
  spec.authors       = ['Leon Hooijer']
  spec.email         = ['mail@leonhooijer.nl']

  spec.summary       = 'A data management gem.'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/leonhooijer/zadok'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
