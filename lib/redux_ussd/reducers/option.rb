# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Register symbols for options and saves the current selection
    class Option
      def self.call(action, state)
        case action[:type]
        when :register_option
          state.deep_merge(action[:screen] => [action[:option]])
        when :select_option
          state.merge(option: action[:option])
        else
          state
        end
      end
    end
  end
end
