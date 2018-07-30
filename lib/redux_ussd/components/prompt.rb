# frozen_string_literal: true

module ReduxUssd
  module Components
    # Models an input prompt with a text.
    class Prompt < Base
      def initialize(options = {})
        super(options)
        @text = options[:text]
      end

      def render
        @text
      end
    end
  end
end
