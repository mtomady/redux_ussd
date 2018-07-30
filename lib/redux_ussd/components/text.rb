require 'redux_ussd/components/base'

module ReduxUssd
  module Components
    # Component to simple text rendering
    class Text < Base
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
