# frozen_string_literal: true

module ReduxUssd
  module Middlewares
    module MiddlewareMock
      def call(_)
        lambda do |forward|
          lambda do |action|
            forward.call(action)
          end
        end
      end
    end
  end
end
