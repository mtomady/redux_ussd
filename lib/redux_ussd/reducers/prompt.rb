# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Registers and sets variables from a prompt input
    class Prompt
      def self.call(action, state)
        case action[:type]
        when :symbolize_values
          state.map { |key, val| [key, val.to_sym ]}.to_h
        when :register_prompt
          state.deeper_merge({ action[:screen] => action[:target] })
        else
          state
        end
      end
    end
  end
end