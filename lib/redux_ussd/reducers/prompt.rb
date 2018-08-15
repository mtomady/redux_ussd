# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Registers and sets variables from a prompt input
    class Prompt
      def self.call(action, state)
        case action[:type]
        when :set_prompt_value
          values = { values: { action[:target] => action[:value] } }
          state.deep_merge(values)
        when :register_prompt
          targets = { targets: { action[:screen] => action[:target].to_sym } }
          state.deep_merge(targets)
        else
          state
        end
      end
    end
  end
end
