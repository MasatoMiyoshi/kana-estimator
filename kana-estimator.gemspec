
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "kana/estimator/version"

Gem::Specification.new do |spec|
  spec.name          = "kana-estimator"
  spec.version       = Kana::Estimator::VERSION
  spec.authors       = ["MasatoMiyoshi"]
  spec.email         = ["miyoshi@sitebridge.co.jp"]

  spec.summary       = %q{A simple kana estimator}
  spec.description   = %q{A simple kana estimator}
  spec.homepage      = "https://github.com/MasatoMiyoshi/kana-estimator"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.6'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov"
end
