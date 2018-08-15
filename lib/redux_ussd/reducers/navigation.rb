# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push
    class Navigation
      def self.call(action, state)
        case action[:type]
        when :push
          action[:screen].to_sym
        else
          state
        end
      end
    end
  end
end
