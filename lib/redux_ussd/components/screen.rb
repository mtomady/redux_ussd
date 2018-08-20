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
        @action = options[:action]
        @components = []
        @store = options[:store]
        @static = options[:static]
      end

      def render
        evaluate_components
        @components.map(&:render).join("\n")
      end

      attr_reader :action
      attr_reader :static
      attr_reader :components

      def action?
        !@action.nil?
      end

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

      def state
        @store.state
      end

      def prompt_or_options?
        option_components.count.positive? || prompt_components.count.positive?
      end

      def option_components
        @components.select { |c| c.is_a?(Option) }
      end

      def prompt_components
        @components.select { |c| c.is_a?(Prompt) }
      end

      private

      def evaluate_components
        @components = []
        DslProxy.new(self).instance_eval(&@block)
      end

      # Proxies the DSL methods to screen methods
      class DslProxy
        extend Forwardable

        def initialize(screen)
          @screen = screen
        end

        def_delegator :@screen, :add_option, :option
        def_delegator :@screen, :add_text, :text
        def_delegator :@screen, :add_prompt, :prompt
        def_delegator :@screen, :state
        def_delegator :@screen, :static
      end
    end
  end
end
