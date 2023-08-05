lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spooky/version"

Gem::Specification.new do |spec|
  spec.name          = "spooky"
  spec.version       = Spooky::VERSION
  spec.authors       = ["Georges Gabereau"]
  spec.email         = ["georges@togethr.app"]

  spec.summary       = "A simple Ruby wrapper for the Ghost Content API."
  spec.description   = "Access the Ghost Content API via Ruby."
  spec.homepage      = "https://github.com/togethr/spooky"
  spec.license       = "MIT"

  file_match = %r{^(test|spec|features)/}
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(file_match) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 6.0"
  spec.add_runtime_dependency "http", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "dotenv", "~> 2.7"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.9"
  spec.add_development_dependency "rubocop", "~> 0.89.0"
end
