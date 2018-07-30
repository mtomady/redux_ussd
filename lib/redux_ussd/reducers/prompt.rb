# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Registers and sets variables from a prompt input
    class Prompt
      def self.call(action, state)
        if action[:type] == :set_prompt_value
          state.merge(values: { state[:target] => action[:value] }) # FIX merge
        elsif action[:type] == :register_prompt
          state.merge(target: action[:target])
        else
          state
        end
      end
    end
  end
end
