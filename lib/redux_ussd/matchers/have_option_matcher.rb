# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def have_option(name, text)
        HaveOptionMatcher.new(name, text)
      end

      class HaveOptionMatcher
        def initialize(name, text)
          @name = name
          @text = text
        end

        def matches?(screen)
          screen.components.any? do |c|
            c.name == @name && c.text == @text
          end
        end
      end
    end
  end
end
