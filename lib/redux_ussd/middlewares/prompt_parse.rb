# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    # Parses raw text input and assigns the text
    # to predefined store variable
    module PromptParse
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            if action[:type] == :handle_raw_input
              current_screen = store.state[:navigation][:current_screen]
              target = store.state[:prompt][:targets][current_screen]
              if target
                store.dispatch(type: :set_prompt_value, target: target,
                               value: action[:raw_input])
              end
            else
              forward.call(action)
            end
          end
        end
      end
    end
  end
end
