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

            unless routes_exist?(routes, current_screen)
              forward.call(action) # TODO: Test
              return
            end

            option_index = parse_input(action[:raw_input])
            screen = screen_at(routes, current_screen, option_index)
            if screen
              store.dispatch(type: :push, screen: screen)
            else
              store.dispatch(type: :push, screen: :option_not_found)
            end
          end
        end
      end

      private

      def self.routes_exist?(routes, current_screen)
        routes.key?(current_screen) && routes[current_screen]&.count&.positive?
      end

      def self.screen_at(routes, current_screen, index)
        return nil unless index < routes[current_screen].count && index >= 0
        routes[current_screen][index]
      end

      def self.parse_input(text)
        begin
          Integer(text) - 1
        rescue ArgumentError
          nil
        end
      end
    end
  end
end
