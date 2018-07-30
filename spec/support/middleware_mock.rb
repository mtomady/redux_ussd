# frozen_string_literal: true

class MiddlewareMock
  attr_reader :store
  attr_reader :action

  def call(store)
    lambda do |forward|
      lambda do |action|
        @store = store
        @action = action
        forward.call(action)
      end
    end
  end
end
