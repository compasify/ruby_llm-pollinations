# frozen_string_literal: true

module RubyLLM
  module SpeakMethod
    def speak(...)
      Pollinations::AudioOutput.speak(...)
    end
  end

  extend SpeakMethod unless respond_to?(:speak)

  unless Configuration.options.include?(:default_audio_model)
    Configuration.send(:option, :default_audio_model, 'tts-1')
  end
end
