# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Register symbols for options and saves the current selection
    class Option
      def self.call(action, state)
        case action[:type]
        when :register_option
          options = { action[:screen] => [action[:option].to_sym] }
          state.deep_merge(options)
        when :select_option
          state.merge(option: action[:option].to_sym)
        else
          state
        end
      end
    end
  end
end
