lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name         = 'libtad'
  spec.description  = 'Library for accessing Time and Date APIs'
  spec.summary      = 'Time and Date API client'
  spec.files        = Dir["{lib}/**/*.rb"]
  spec.authors      = ['Daniel Alvsåker']
  spec.email        = 'api@timeanddate.com'
  spec.license      = 'MIT'
  spec.homepage     = 'https://timeanddate.com'
  spec.version      = '0.1.0'

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.10"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "rdoc"
end
