# frozen_string_literal: true

require_relative 'lib/ruby_llm/pollinations/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby_llm-pollinations'
  spec.version       = RubyLLM::Pollinations::VERSION
  spec.authors       = ['Compasify']
  spec.email         = ['timdapan.com@gmail.com']

  spec.summary       = 'Pollinations AI provider for RubyLLM'
  spec.description   = 'Adds Pollinations AI support to RubyLLM — chat, image/video generation, ' \
                       'TTS/music, and transcription via the Pollinations API. ' \
                       'Installs as a standalone gem without modifying RubyLLM core.'
  spec.homepage      = 'https://github.com/compasify/ruby_llm-pollinations'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.1.3')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.glob('lib/**/*') + ['README.md', 'LICENSE']
  spec.require_paths = ['lib']

  spec.add_dependency 'ruby_llm', '>= 1.14.0'
end
