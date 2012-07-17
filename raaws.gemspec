# -*- encoding: utf-8 -*-
require File.expand_path('../lib/raaws/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["charlysisto"]
  gem.email         = ["charlysisto@gmail.com"]
  gem.description   = %q{Amazon API for Product Advertising}
  gem.summary       = %q{(don't) Use it (yet) with rails to build your amazon shop.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "raaws"
  gem.require_paths = ["lib"]
  gem.version       = Raaws::VERSION
end
