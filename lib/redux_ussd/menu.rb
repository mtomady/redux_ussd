require 'redux_ussd/components/screen'
require 'redux_ussd/store'
require 'redux_ussd/reducers/navigation'
require 'redux_ussd/reducers/prompt'
require 'redux_ussd/middlewares/option_select'
require 'redux_ussd/middlewares/prompt_parse'
require 'redux_ussd/middlewares/prompt_parse'

module ReduxUssd
  class Menu
    class Proxy
      extend Forwardable

      def initialize(menu)
        @menu = menu
      end

      def_delegator :@menu, :add_screen, :screen
      def_delegator :@menu, :state, :state
    end

    attr_writer :initial_state

    def initialize
      @initial_state = {
          navigation: {
              current_screen: :index,
              routes: {}
          },
          prompt: {}
      }
      middlewares = [
          Middlewares::OptionSelect,
          Middlewares::PromptParse
      ]
      reducers = {
          navigation: Reducers::Navigation,
          prompt: Reducers::Prompt
      }
      @store = Store.new(@initial_state,
                         middlewares,
                         reducers)
    end

    def render
      current_screen = @store.state[:navigation][:current_screen]
      screen = screens[current_screen]
      output = screen.render
      instance_eval(&screen.process_block)
      output
    end

    def handle_raw_input(raw_input)
      @store.dispatch(type: :handle_raw_input, raw_input: raw_input)
    end

    def end?
      current_screen = @store.state[:navigation][:current_screen]
      (@store.state[:navigation][:routes][current_screen] || []).empty?
    end

    def add_screen(name, _options = {}, &block)
      screens[name] = Components::Screen.new(
        name: name,
        store: @store,
        block: block
      )
    end

    def state
      @store.state
    end
    # def will_mount
    #   return unless @process_block
    #   @store.unsubscribe(@process_block)
    # end
    #
    # def will_unmount
    #   return unless @process_block
    #   @store.subscribe do
    #     @process_block.call(@store.state)
    #   end
    # end
    #

    private

    def session
      @session
    end

    def push(screen)
      @store.dispatch(type: :push, screen: screen)
    end

    def screens
      @screens ||= {}
    end
  end
end
