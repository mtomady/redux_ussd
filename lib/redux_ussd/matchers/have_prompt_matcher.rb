# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def have_prompt_component(name, text)
        HavePromptMatcher.new(name, text)
      end

      class HavePromptMatcher
        def initialize(name, text)
          @name = name
          @text = text
        end

        def matches?(screen)
          screen.prompt_components.any? do |c|
            c.name == @name && c.text == @text
          end
        end

        def failure_message
          "Should have a prompt component with name #{@name} and text #{@text}"
        end

        def description
          "have a prompt component with name #{@name} and text #{@text}"
        end
      end
    end
  end
end
