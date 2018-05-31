# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
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

  s.add_dependency "bootstrap", "~> 4.0"
  s.add_dependency "bundler-audit", "~> 0.6"
  s.add_dependency "brakeman", "~> 4.3"
  s.add_dependency "cancancan", "~> 2.1"
  s.add_dependency "devise", "~> 4.4"
  s.add_dependency "devise-i18n", "~> 1.5"
  s.add_dependency "devise_invitable", "~> 1.7"
  s.add_dependency "font-awesome-rails", "~> 4.7"
  s.add_dependency "jquery-rails", "~> 4.3"
  s.add_dependency "jquery-turbolinks", "~> 2.1"
  s.add_dependency "jquery-ui-rails", "~> 6.0"
  s.add_dependency "loaf", "~> 0.6"
  s.add_dependency "localer", "~> 0.1"
  s.add_dependency "pg", "~> 1.0"
  s.add_dependency "puma", "~> 3.11"
  s.add_dependency "rails", "~> 5.1"
  s.add_dependency "rails-i18n", "~> 5.0"
  s.add_dependency "ransack", "~> 1.8"
  s.add_dependency "rubocop", "~> 0.52"
  s.add_dependency "rumination", "~> 0.17"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "slim-rails", "~> 3.1"
  s.add_dependency "turbolinks", "~> 5.1"
  s.add_dependency "uglifier", "~> 4.1"
  s.add_dependency "will-paginate-i18n", "~> 0.1"
  s.add_dependency "will_paginate", "~> 3.1"
end
