# frozen_string_literal: true

require 'redux_ussd/components/screen'
require 'redux_ussd/store'
require 'redux_ussd/reducers/navigation'
require 'redux_ussd/reducers/prompt'
require 'redux_ussd/reducers/option'
require 'redux_ussd/reducers/options'
require 'redux_ussd/reducers/end'
require 'redux_ussd/reducers/value'
require 'redux_ussd/middlewares/option_select'
require 'redux_ussd/middlewares/prompt_parse'
require 'redux_ussd/middlewares/end'

module ReduxUssd
  # Configures a menu, setups all view components and
  # handles inputs using a redux store
  class Menu
    def initialize(state: nil, static: nil)
      @store = Store.new(state || {},
                         middlewares,
                         reducers)
      @static = static || {}
      @store.dispatch(type: :symbolize_values)
    end

    def render
      current_screen = @store.state[:navigation][:current]
      screens[current_screen].render
    end

    def handle_raw_input(raw_input)
      @store.dispatch(type: :handle_raw_input, raw_input: raw_input)
      current_screen = @store.state[:navigation][:current]
      # Move call to separate proxy
      actions[screens[current_screen].action].call if screens[current_screen].action?
    end

    def requires_input?
      current_screen = @store.state[:navigation][:current]
      screens[current_screen].prompt_or_options?
    end

    def end?
      current_screen = @store.state[:navigation][:current]
      @store.dispatch(type: :force_end) if screens[current_screen].end?
      @store.state[:end]
    end

    def force_end
      @store.dispatch(type: :force_end)
    end

    def register_screen(name, action: nil, force_end: false, &block)
      screens[name] = Components::Screen.new(
        name: name,
        action: action,
        store: @store,
        block: block,
        static: @static,
        force_end: force_end
      )
      @store.dispatch(type: :register_screen, screen: name)
    end

    def register_action(name, &block)
      actions[name] = block
    end

    def state
      @store.state
    end

    attr_reader :static

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
        options: Reducers::Options,
        option: Reducers::Option,
        prompt: Reducers::Prompt,
        end: Reducers::End,
        values: Reducers::Value
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
      def_delegator :@menu, :static, :static
      def_delegator :@menu, :push, :push
      def_delegator :@menu, :force_end, :force_end
    end
  end
end
