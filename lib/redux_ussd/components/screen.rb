# frozen_string_literal: true

require 'redux_ussd/components/text'
require 'redux_ussd/components/prompt'
require 'redux_ussd/components/option'
require 'forwardable'

module ReduxUssd
  module Components
    # Container component for prompts, text and options
    class Screen < Base
      def initialize(options = {})
        @name = options[:name]
        @block = options[:block]
        @components = []
        @store = options[:store]
      end

      def render
        @components = []
        Proxy.new(self).instance_eval(&@block)
        @components.map(&:render).join("\n")
      end

      attr_reader :after

      def add_option(name, options = {})
        @components.push(Option.new(
                           option_index: option_components.count + 1,
                           name: name,
                           text: options[:text]
        ))
        @store.dispatch(type: :register_option,
                        screen: @name,
                        option: name)
      end

      def add_text(text)
        @components.push(Text.new(text: text))
      end

      def add_prompt(name, options = {})
        @components.push(Prompt.new(name: name, text: options[:text]))
        @store.dispatch(type: :register_prompt,
                        screen: @name, # TODO: RENMAE
                        target: name)
      end

      attr_reader :after

      def register_after(&block)
        @after = block
      end

      def state
        @store.state
      end

      def dispatch_push(screen)
        @store.dispatch(type: :push, screen: screen)
      end

      def has_prompt_or_options?
        option_components.count > 0 || prompt_components.count > 0
      end

      private

      def option_components
        @components.select { |c| c.is_a?(Option) }
      end

      def prompt_components
        @components.select { |c| c.is_a?(Prompt) }
      end

      # Proxies the DSL methods to screen methods
      class Proxy
        extend Forwardable

        def initialize(screen)
          @screen = screen
        end

        def_delegator :@screen, :add_option, :option
        def_delegator :@screen, :dispatch_push, :push
        def_delegator :@screen, :add_text, :text
        def_delegator :@screen, :add_prompt, :prompt
        def_delegator :@screen, :register_after, :after
        def_delegator :@screen, :state
      end
    end
  end
end
