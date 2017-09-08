# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hex_token_bot/version"

Gem::Specification.new do |spec|
  spec.name          = "hex_token_bot"
  spec.version       = HexTokenBot::VERSION
  spec.authors       = ["Terry"]
  spec.email         = ["tuminfei1981@gmail.com"]

  spec.summary       = %q{58token bot.}
  spec.description   = %q{58token bot.}
  spec.homepage      = "https://github.com/tuminfei/hex_token_bot"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'railties', '>= 3.1.0'
  #spec.add_dependency 'ruleby', '~> 0.8'
  spec.add_dependency 'faraday', '~> 0.9.0'
  spec.add_dependency 'peatio_client'
  spec.add_dependency 'rufus-scheduler', '>= 3.4.2'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
