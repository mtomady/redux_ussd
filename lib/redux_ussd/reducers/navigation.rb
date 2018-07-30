# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push and :register_route
    class Navigation
      def self.call(action, state)
        case action[:type]
        when :push
          state.merge(current_screen: action[:screen])
        when :register_route
          routes = (state[:routes][action[:screen]] || []) + [action[:target]]
          state.merge(routes: state[:routes].merge(action[:screen] => routes))
        else
          state
        end
      end
    end
  end
end
