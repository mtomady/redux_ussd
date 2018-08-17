# frozen_string_literal: true

require 'redux_ussd/version'
require 'redux_ussd/menu'
require 'redux_ussd/store'

# Makes the menu DSL accessible to a class
module ReduxUssd
  def setup_menu(options = {})
    @menu ||= begin
      options[:state] = (options[:state] || ReduxUssd.initial_state) # .deep_symbolize_keys
      ReduxUssd::Menu.new(options).tap do |menu|
        Menu::DslProxy.new(menu).instance_eval(&self.class.menu)
      end
    end
  end

  def menu
    @menu
  end

  def self.included(klass)
    klass.extend ClassMethods
  end

  private

  def symbolize(state); end

  # Holds a class-level definition of the menu DSL
  module ClassMethods
    def menu(&block)
      @menu_block ||= block
    end
  end

  def self.initial_state
    {
      navigation: {
          screens: [],
          current: :index
      },
      options: {},
      prompt: {
        targets: {},
        values: {}
      },
      end: false
    }
  end
end
