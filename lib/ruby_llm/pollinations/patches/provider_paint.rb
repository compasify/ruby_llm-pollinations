# frozen_string_literal: true

module RubyLLM
  class Provider
    unless instance_method(:paint).parameters.any? { |type, _| type == :keyrest }
      def paint(prompt, model:, size:, **options)
        payload = render_image_payload(prompt, model: model, size: size, **options)
        response = @connection.post images_url, payload
        parse_image_response(response, model: model)
      end
    end
  end
end
