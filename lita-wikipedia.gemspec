Gem::Specification.new do |spec|
  spec.name          = "lita-wikipedia"
  spec.version       = "0.0.4"
  spec.authors       = ["Tristan Chong"]
  spec.email         = ["ong@tristaneuan.ch"]
  spec.description   = %q{A Lita handler that returns a requested Wikipedia article.}
  spec.summary       = %q{A Lita handler that returns a requested Wikipedia article.}
  spec.homepage      = "https://github.com/tristaneuan/lita-wikipedia"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 3.1"
  spec.add_runtime_dependency "nokogiri", ">= 1.6.6"
  spec.add_runtime_dependency "sanitize", ">= 3.1.2"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 3.0.0.beta2"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
