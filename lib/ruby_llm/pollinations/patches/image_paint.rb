# frozen_string_literal: true

module RubyLLM
  class Image
    class << self
      unless method_defined?(:_pollinations_patched_paint)
        alias _original_paint paint

        def paint(prompt, model: nil, provider: nil, assume_model_exists: false, size: '1024x1024', context: nil, **options) # rubocop:disable Metrics/ParameterLists
          config = context&.config || RubyLLM.config
          model ||= config.default_image_model
          model, provider_instance = Models.resolve(model, provider: provider, assume_exists: assume_model_exists,
                                                           config: config)
          model_id = model.id

          provider_instance.paint(prompt, model: model_id, size: size, **options)
        end

        def _pollinations_patched_paint = true
      end
    end
  end
end
