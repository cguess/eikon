require_relative "lib/eikon/version"

Gem::Specification.new do |spec|
  spec.name          = "eikon"
  spec.version       = Eikon::VERSION
  spec.authors       = ["Christopher Guess"]
  spec.email         = ["cguess@gmail.com"]

  spec.summary       = "A small pure-Ruby (for now) implementation of DHash"
  spec.description   = "A small pure-Ruby (for now) implementation of DHash"
  spec.homepage      = "https://www.github.com/cguess/eikon"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://www.github.com/cguess/eikon"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.

  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "ruby-vips", "~> 2.1"
  spec.add_runtime_dependency "terrapin", "~> 0.6.0"
  spec.add_runtime_dependency "sorbet-runtime", ">= 0.5.9204"
  spec.add_runtime_dependency "mutex_m"
end
