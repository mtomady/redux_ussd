# frozen_string_literal: true

require 'redux_ussd/components/screen'
require 'redux_ussd/store'
require 'redux_ussd/reducers/navigation'
require 'redux_ussd/reducers/prompt'
require 'redux_ussd/reducers/option'
require 'redux_ussd/reducers/end'
require 'redux_ussd/middlewares/option_select'
require 'redux_ussd/middlewares/prompt_parse'
require 'redux_ussd/middlewares/end'

module ReduxUssd
  # Configures a menu, setups all view components and
  # handles inputs using a redux store
  class Menu
    def initialize(options = {})
      @store = Store.new(options[:state] || {},
                         middlewares,
                         reducers)
      @session = options[:session] || {}
      @store.dispatch(type: :symbolize_navigation)
    end

    def render
      current_screen = @store.state[:navigation][:current]
      screens[current_screen].render
    end

    def handle_raw_input(raw_input)
      @store.dispatch(type: :handle_raw_input, raw_input: raw_input)
      current_screen = @store.state[:navigation][:current]
      actions[screens[current_screen].action].call if screens[current_screen].action?
    end

    def check_end?
      current_screen = @store.state[:navigation][:current]
      @store.dispatch(type: :force_end) unless screens[current_screen].action?
      @store.state[:end]
    end

    def register_screen(name, options = {}, &block)
      screens[name] = Components::Screen.new(
        name: name,
        action: options[:action],
        store: @store,
        block: block
      )
      @store.dispatch(type: :register_screen, screen: name)
    end

    def register_action(name, &block)
      actions[name] = block
    end

    def state
      @store.state
    end

    attr_reader :session # TODO

    def push(screen)
      # TODO: Test
      @store.dispatch(type: :push, screen: screen)
    end

    def screens
      @screens ||= {}
    end

    def actions
      @actions ||= {}
    end

    private

    def middlewares
      [
        Middlewares::OptionSelect,
        Middlewares::PromptParse,
        Middlewares::End
      ]
    end

    def reducers
      {
        navigation: Reducers::Navigation,
        options: Reducers::Option,
        prompt: Reducers::Prompt,
        end: Reducers::End
      }
    end

    # Proxies the DSL methods to menu methods
    class DslProxy
      extend Forwardable

      def initialize(menu)
        @menu = menu
      end

      def_delegator :@menu, :register_screen, :screen
      def_delegator :@menu, :register_action, :action
      def_delegator :@menu, :state, :state
      def_delegator :@menu, :session, :session
      def_delegator :@menu, :push, :push
    end
  end
end
