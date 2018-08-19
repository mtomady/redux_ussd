# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Register symbols for options and saves the current selection
    class Options
      def self.call(action, state)
        case action[:type]
        when :symbolize_values
          state.map { |key, val| [key, val.map(&:to_sym) ]}.to_h
        when :register_option
          state.deeper_merge(action[:screen] => [action[:option]])
        else
          state
        end
      end
    end
  end
end