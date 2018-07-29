module ReduxUssd
  module Components
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
