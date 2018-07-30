# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    # Middleware to convert input number into :push screen actions
    module OptionSelect
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            unless action[:type] == :handle_raw_input
              forward.call(action)
              return
            end

            routes = store.state[:navigation][:routes]
            current_screen = store.state[:navigation][:current_screen]

            unless routes.key?(current_screen) || routes[current_screen]&.
                count&.positive?
              forward.call(action) # TODO: Test
              return
            end

            begin
              option_index = Integer(action[:raw_input]) - 1
            rescue ArgumentError
              store.dispatch(type: :push, screen: :option_not_found)
            end

            if option_index < routes[current_screen].count &&
               option_index >= 0
              screen = routes[current_screen][option_index]
              store.dispatch(type: :push, screen: screen)
            else
              store.dispatch(type: :push, screen: :option_not_found)
            end
          end
        end
      end
    end
  end
end
