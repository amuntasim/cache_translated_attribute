# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cache_translated_attribute/version'

Gem::Specification.new do |spec|
  spec.name          = "cache_translated_attribute"
  spec.version       = CacheTranslatedAttribute::VERSION
  spec.authors       = ["Muntasim"]
  spec.email         = ["ahmed2tul@gmail.com"]
<<<<<<< HEAD
  spec.description   = %q{Cache translated attributes (facilitated by globalize3 gem) to reduce db call
}
  spec.summary       = %q{tested with redis as cache storage, support of other storage in the pipeline}
=======
  spec.description   = %q{Cache translated attributes (facilitated by globalize3 gem) to reduce db call}
  spec.summary       = %q{Cache translated attributes (facilitated by globalize3 gem) to reduce db call}
>>>>>>> 701dcc417a1310daf148655e81fd294825225a4d
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 3.1'

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'globalize', '>= 3.0'
  spec.add_development_dependency 'rspec', ['>= 0']
end
