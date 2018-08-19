# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def use_action(action_name)
        UseActionMatcher.new(action_name)
      end

      class UseActionMatcher
        def initialize(action_name)
          @action_name = action_name
        end

        def matches?(screen)
          screen.action == @action_name
        end

        def failure_message
          "Should use action #{@action_name}"
        end

        def description
          "use action #{@action_name}"
        end
      end
    end
  end
end
