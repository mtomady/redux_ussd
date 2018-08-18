# frozen_string_literal: true

module ReduxUssd
  module Components
    # Acts as a numbered, selectable option in a menu
    class Option < Base
      def initialize(options = {})
        super(options)
        @option_index = options[:option_index]
        @text = options[:text]
      end

      attr_reader :text
      attr_reader :option_index

      def render
        "#{@option_index}. #{@text}"
      end
    end
  end
end
