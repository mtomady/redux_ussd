# frozen_string_literal: true

module ReduxUssd
  module Reducers
    # Handles navigation related action such as :push
    class End
      def self.call(action, state)
        case action[:type]
        when :force_end
          true
        else
          state
        end
      end
    end
  end
end
