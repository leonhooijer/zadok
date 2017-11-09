# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "zadok/version"

Gem::Specification.new do |s|
  s.name          = "zadok"
  s.version       = Zadok::VERSION
  s.date          = Time.now.strftime("%Y-%m-%d")
  s.authors       = ["Leon Hooijer"]
  s.email         = ["mail@leonhooijer.nl"]

  s.summary       = "A data management gem."
  s.description   = s.summary
  s.homepage      = "https://github.com/leonhooijer/zadok"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "bootstrap", "~> 4.0.0.beta2.1"
  s.add_dependency "cancancan", "~> 2.0"
  s.add_dependency "font-awesome-rails", "~> 4.7"
  s.add_dependency "jquery-rails", "~> 4.3"
  s.add_dependency "jquery-ui-rails", "~> 6.0"
  s.add_dependency "pg", "~> 0.21"
  s.add_dependency "rails", "~> 5.1"
  s.add_dependency "ransack", "~> 1.8"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "slim-rails", "~> 3.1"
  s.add_dependency "will_paginate", "~> 3.1"

  s.add_development_dependency "rubocop"
end
