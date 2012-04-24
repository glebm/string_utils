# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "string_utils/version"

Gem::Specification.new do |s|
  s.name              = "string_utils"
  s.version           = StringUtils::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Gleb Mazovetskiy"]
  s.email             = ["glex.spb@gmail.com"]
  s.homepage          = "http://github.com/glebm/string_utils"
  s.summary           = %q{Word truncation, punctuation normalization, and other useful string methods}

  s.rubyforge_project = "string_utils"

  
  s.add_dependency "activesupport", ">= 2.3.5"
  s.add_dependency "i18n"

  s.add_development_dependency "rspec", ">= 2.0.0"

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths     = ["lib"]
end
