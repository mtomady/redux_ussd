module ReduxUssd
  module Components
    class Base
      def initialize(options = {})
        @name = options[:name]
      end

      attr_reader :name

      def render
        raise NotImplementedError
      end
    end
  end
end
