# frozen_string_literal: true

require 'ruby_llm'

require_relative 'ruby_llm/pollinations/version'
require_relative 'ruby_llm/pollinations/audio_output'
require_relative 'ruby_llm/pollinations/patches/provider_paint'
require_relative 'ruby_llm/pollinations/patches/image_paint'
require_relative 'ruby_llm/pollinations/patches/speak'
require_relative 'ruby_llm/pollinations/provider/capabilities'
require_relative 'ruby_llm/pollinations/provider/chat'
require_relative 'ruby_llm/pollinations/provider/streaming'
require_relative 'ruby_llm/pollinations/provider/tools'
require_relative 'ruby_llm/pollinations/provider/media'
require_relative 'ruby_llm/pollinations/provider/images'
require_relative 'ruby_llm/pollinations/provider/audio'
require_relative 'ruby_llm/pollinations/provider/transcription'
require_relative 'ruby_llm/pollinations/provider/models'
require_relative 'ruby_llm/pollinations/provider/account'
require_relative 'ruby_llm/pollinations/provider/pollinations'

RubyLLM::Provider.register :pollinations, RubyLLM::Pollinations::Provider::Pollinations
