module ReduxUssd
  module Middlewares
    module OptionSelect
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            if action[:type] == :handle_raw_input
              routes = store.state[:navigation][:routes]
              current_screen = store.state[:navigation][:current_screen]
              option_index = Integer(action[:raw_input]) - 1

              if routes.key?(current_screen) # TODO: Test
                if option_index < routes[current_screen].count &&
                   option_index >= 0
                  screen = routes[current_screen][option_index]
                  store.dispatch(type: :push, screen: screen)
                else
                  store.dispatch(type: :push, screen: :option_not_found)
                end
                nil
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
