# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push
    class Navigation
      def self.call(action, state)
        case action[:type]
        when :symbolize_navigation
          { screens: (state[:screens] || []).map(&:to_sym),
            current: state[:current]&.to_sym }
        when :register_screen
          state.deep_merge(screens: [action[:screen]])
        when :push
          return state unless state[:screens].include?(action[:screen])
          state.merge(current: action[:screen])
        else
          state
        end
      end
    end
  end
end
