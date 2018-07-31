# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push
    class Navigation
      def self.call(action, state)
        case action[:type]
        when :push
          state.merge(current_screen: action[:screen])
        else
          state
        end
      end
    end
  end
end
