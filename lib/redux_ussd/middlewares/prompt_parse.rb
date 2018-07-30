# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    # Parses raw text input and assigns the text
    # to predefined store variable
    module PromptParse
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            if action[:type] == :handle_raw_input && store.state[:prompt][:key]
              store.dispatch(type: :fill_prompt,
                             key: store.state[:prompt][:key],
                             value: action[:raw_input])
            else
              forward.call(action)
            end
          end
        end
      end
    end
  end
end
