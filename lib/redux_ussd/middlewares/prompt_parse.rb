# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    # Parses raw text input and assigns the text
    # to predefined store variable
    module PromptParse
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            handle_raw_input(store, action) if action[:type] == :handle_raw_input
            forward.call(action)
          end
        end
      end

      def self.handle_raw_input(store, action)
        current_screen = store.state[:navigation][:current]
        target = store.state[:prompt][:targets][current_screen]
        return unless target
        store.dispatch(type: :set_prompt_value, target: target,
                       value: action[:raw_input])
      end
    end
  end
end
