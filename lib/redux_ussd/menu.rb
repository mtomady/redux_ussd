# frozen_string_literal: true

require 'redux_ussd/components/screen'
require 'redux_ussd/store'
require 'redux_ussd/reducers/navigation'
require 'redux_ussd/reducers/prompt'
require 'redux_ussd/middlewares/option_select'
require 'redux_ussd/middlewares/prompt_parse'
require 'redux_ussd/middlewares/prompt_parse'

module ReduxUssd
  # Configures a menu, setups all view components and
  # handles inputs using a redux store
  class Menu
    def initialize(initial_state = {})
      @store = Store.new(initial_state,
                         middlewares,
                         reducers)
    end

    def render
      current_screen = @store.state[:navigation][:current_screen]
      screens[current_screen].render
    end

    def handle_raw_input(raw_input)
      @store.dispatch(type: :handle_raw_input, raw_input: raw_input)
    end

    def end?
      current_screen = @store.state[:navigation][:current_screen]
      (@store.state[:navigation][:routes][current_screen] || []).empty?
    end

    def add_screen(name, &block)
      screens[name] = Components::Screen.new(
        name: name,
        store: @store,
        block: block
      )
    end

    def state
      @store.state
    end

    private

    def push(screen)
      @store.dispatch(type: :push, screen: screen)
    end

    def screens
      @screens ||= {}
    end

    def middlewares
      [
        Middlewares::OptionSelect,
        Middlewares::PromptParse
      ]
    end

    def reducers
      {
        navigation: Reducers::Navigation,
        prompt: Reducers::Prompt
      }
    end

    # Proxies the DSL methods to menu methods
    class Proxy
      extend Forwardable

      def initialize(menu)
        @menu = menu
      end

      def_delegator :@menu, :add_screen, :screen
      def_delegator :@menu, :state, :state
    end
  end
end
