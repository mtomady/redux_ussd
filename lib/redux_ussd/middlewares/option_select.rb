# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    # Middleware to convert input number into :push screen actions
    module OptionSelect
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            handle_raw_input(store, action) if action[:type] ==
                                               :handle_raw_input
            forward.call(action) # TODO: Test
          end
        end
      end

      def self.handle_raw_input(store, action)
        options = store.state[:options]
        current_screen = store.state[:navigation][:current_screen]

        return unless options_exist?(options, current_screen)
        option_index = parse_input(action[:raw_input])
        option = screen_at(options, current_screen, option_index)
        store.dispatch(type: :select_option, screen: current_screen,
                       option: option)
      end

      # TODO: Make private
      def self.options_exist?(options, current_screen)
        options.key?(current_screen) &&
          options[current_screen]&.count&.positive?
      end

      def self.screen_at(options, current_screen, index)
        return nil unless index < options[current_screen].count && index >= 0
        options[current_screen][index]
      end

      def self.parse_input(text)
        Integer(text) - 1
      rescue ArgumentError
        nil
      end
    end
  end
end
