module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push and :register_route
    class Navigation
      def self.call(action, state)
        if action[:type] == :push
          state.merge(current_screen: action[:screen])
        elsif action[:type] == :register_route
          action_routes = (state[:routes][action[:screen]] || []) +
                          [action[:target]]
          routes = state[:routes].merge(action[:screen] => action_routes)
          state.merge(routes: routes)
        else
          state
        end
      end
    end
  end
end
