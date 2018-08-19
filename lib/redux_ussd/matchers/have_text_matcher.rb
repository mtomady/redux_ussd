# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def have_text_component(text)
        HaveTextMatcher.new(text)
      end

      class HaveTextMatcher
        def initialize(text)
          @text = text
        end

        def matches?(screen)
          screen.components.any? do |c|
            c.text == @text
          end
        end
      end
    end
  end
end
