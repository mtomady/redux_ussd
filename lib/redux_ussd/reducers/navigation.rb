# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push
    class Navigation
      def self.call(action, state)
        case action[:type]
        when :push
          action[:screen]
        else
          state.to_sym
        end
      end
    end
  end
end
