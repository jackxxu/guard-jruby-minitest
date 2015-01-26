# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guard/jruby-minitest/version'

Gem::Specification.new do |spec|
  spec.name          = "guard-jruby-minitest"
  spec.version       = Guard::JRubyMinitestVersion::VERSION
  spec.authors       = ["Jack Xu"]
  spec.email         = ["jackxxu@gmail.com"]
  spec.summary       = %q{Guard gem for JRuby Minitest}
  spec.description   = %q{Guard::JRubyMinitest keeps a warmed up JVM ready to run your tests.}
  spec.homepage      = "https://github.com/jackxxu/guard-jruby-minitest"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'minitest'
  spec.add_dependency 'guard', '>= 0.10.0'
  spec.add_dependency 'guard-minitest', '2.3.1'
  spec.add_dependency 'ruby_parser', '>= 3.0'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
