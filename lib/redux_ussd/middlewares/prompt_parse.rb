module ReduxUssd
  module Middlewares
    module PromptParse
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            if action[:type] == :handle_raw_input
              if store.state[:prompt][:key]
                store.dispatch(type: :fill_prompt,
                               key: store.state[:prompt][:key],
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
