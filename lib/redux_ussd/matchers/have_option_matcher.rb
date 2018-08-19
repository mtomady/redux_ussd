# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def have_option_component(name, text, options = {})
        HaveOptionMatcher.new(name, text, options)
      end

      class HaveOptionMatcher
        def initialize(name, text, options = {})
          @name = name
          @text = text
          @index = options[:index]
        end

        def matches?(screen)
          screen.components.any? do |c|
            c.name == @name && c.text == @text && (@index.nil? ? true : c.option_index == @index)
          end
        end

        def failure_message
          "Should have a option :#{name} with text #{@text}"
        end

        def description
          "have a option :#{@name} with text #{@text}"
        end
      end
    end
  end
end
