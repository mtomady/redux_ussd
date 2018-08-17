# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Registers and sets variables from a prompt input
    class Prompt
      def self.call(action, state)
        case action[:type]
        when :set_prompt_value
          state.deep_merge(values: { action[:target] => action[:value] })
        when :register_prompt
          state.deep_merge(targets: { action[:screen] => action[:target] })
        else
          state
        end
      end
    end
  end
end
