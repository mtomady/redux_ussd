# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    # Middleware to convert input number into :push screen actions
    module End
      def self.call(store)
        lambda do |forward|
          lambda do |action|
            # Cancel everything if the session was already ended
            return if store.state[:end]
            # current_screen = store.state[:navigation][:current]
            # if action[:type] == :handle_raw_input && !store.state[:prompt][:targets][current_screen] && (store.state[:options][current_screen] || []).empty?
            #  store.dispatch(type: :force_end)
            # else
            forward.call(action) # TODO: Test
          end
        end
      end
    end
  end
end
