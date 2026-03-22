# frozen_string_literal: true

module RubyLLM
  module SpeakMethod
    def speak(...)
      Pollinations::AudioOutput.speak(...)
    end
  end

  extend SpeakMethod unless respond_to?(:speak)

  Configuration.class_eval do
    unless method_defined?(:default_audio_model)
      self.class.send(:attr_accessor, :default_audio_model)

      prepend(Module.new do
        def initialize
          super
          self.default_audio_model = 'tts-1'
        end
      end)
    end
  end
end
