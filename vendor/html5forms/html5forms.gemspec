# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "html5forms/version"

Gem::Specification.new do |s|
  s.name        = "html5forms"
  s.version     = Html5Forms::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Vladimir Terekhov"]
  s.email       = ["zarkzork@gmail.com"]
  s.summary     = %q{html5 form builder for rails.}
  s.description = %q{Form builder for rails 3 that creates client side form validation based on model.}

  s.add_runtime_dependency "rails", "~>3.0"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
