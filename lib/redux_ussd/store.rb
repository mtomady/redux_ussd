# frozen_string_literal: true

require 'redux_ussd/reducers/navigation'
require 'deep_merge/rails_compat'

module ReduxUssd
  # Dispatches action and mutates state using middlewares and reducers
  class Store
    attr_reader :state

    def initialize(initial_state = {},
                   middlewares = [],
                   reducers = {},
                   listeners = [])
      @state = initial_state
      @reducers = reducers
      @middlewares = middlewares.reverse
      @listeners = listeners
    end

    def dispatch(action = {})
      # Setup middlewares and reducers
      dispatch_lambda = method(:reduce)
      @middlewares.each do |m|
        dispatch_lambda = m.call(self).call(dispatch_lambda)
      end

      # Run the chain and update the state
      dispatch_lambda.call(action)&.tap do |new_state|
        @state = new_state

        # Notify all listeners
        @listeners.each(&:call)
      end
    end

    def subscribe(&block)
      @listeners.push(block)
    end

    private

    def reduce(action)
      @reducers.reduce(@state) do |state, (key, reducer)|
        state.merge(key => reducer.call(action, state[key]))
      end
    end
  end
end
