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

  s.add_dependency "bootstrap"
  s.add_dependency "cancancan"
  s.add_dependency "font-awesome-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "pg"
  s.add_dependency "rails"
  s.add_dependency "ransack"
  s.add_dependency "sass-rails"
  s.add_dependency "slim-rails"
  s.add_dependency "will_paginate"

  s.add_development_dependency "rubocop"
end
