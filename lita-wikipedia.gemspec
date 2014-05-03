Gem::Specification.new do |spec|
  spec.name          = "lita-wikipedia"
  spec.version       = "0.0.1"
  spec.authors       = ["Tristan Chong"]
  spec.email         = ["ong@tristaneuan.ch"]
  spec.description   = %q{A Lita handler that returns Wikipedia articles.}
  spec.summary       = %q{A Lita handler that returns Wikipedia articles.}
  spec.homepage      = "https://github.com/tristaneuan/lita-wikipedia"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.1"
  #spec.add_runtime_dependency "wikipedia-client", ">= 1.3.3"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
