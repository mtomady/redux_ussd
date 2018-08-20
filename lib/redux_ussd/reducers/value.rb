# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Registers and sets variables from a prompt input
    class Value
      def self.call(action, state)
        case action[:type]
        when :set_value
          state.deeper_merge(action[:target] => action[:value])
        else
          state
        end
      end
    end
  end
end
