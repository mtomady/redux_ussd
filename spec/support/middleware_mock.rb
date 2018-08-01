# frozen_string_literal: true

class MiddlewareMock
  attr_reader :store
  attr_reader :action

  def initialize(should_forward = true)
    @should_forward = should_forward
  end

  def call(store)
    lambda do |forward|
      lambda do |action|
        @store = store
        @action = action
        forward.call(action) if @should_forward
      end
    end
  end
end
