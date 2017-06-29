# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gbre/version"

Gem::Specification.new do |spec|
  spec.name          = "gbre"
  spec.version       = Gbre::VERSION
  spec.authors       = ["Nate Geslin"]
  spec.email         = ["teamtomkins23@gmail.com"]

  spec.summary       = %q{git branch with issue status and title.}
  spec.description   = %q{git branch with issue status and title pulled from GitHub}
  spec.homepage      = "http://github.com/n8rzz/gbre"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables << 'gbre'
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
