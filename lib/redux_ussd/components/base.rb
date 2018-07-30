module ReduxUssd
  module Components
    # Abstract base component that assigns a name
    # from the constructor options
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
