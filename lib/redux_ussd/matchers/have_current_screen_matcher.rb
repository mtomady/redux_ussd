# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def have_current_screen(screen_name)
        HaveCurrentScreenMatcher.new(screen_name)
      end

      class HaveCurrentScreenMatcher
        def initialize(screen_name)
          @screen_name = screen_name
        end

        def matches?(menu)
          menu.state[:navigation][:current] == @screen_name
        end

        def failure_message
          "Should have current screen :#{@screen_name}"
        end

        def description
          "have current screen :#{@screen_name}"
        end
      end
    end
  end
end
