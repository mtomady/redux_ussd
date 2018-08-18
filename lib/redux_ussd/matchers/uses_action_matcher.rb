# frozen_string_literal: true

module ReduxUssd
  module Shoulda
    module Matchers
      def uses_action(action_name)
        UsesActionMatcher.new(action_name)
      end

      class UsesActionMatcher
        def initialize(action_name)
          @action_name = action_name
        end

        def matches?(screen)
          screen.action == @action_name
        end
      end
    end
  end
end
