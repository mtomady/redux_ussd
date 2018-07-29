require 'redux_ussd/version'
require 'redux_ussd/menu'
require 'redux_ussd/store'

module ReduxUssd
  def menu
    @menu ||= ReduxUssd::Menu.new.tap do |menu|
      Menu::Proxy.new(menu).instance_eval(&self.class.menu)
    end
  end

  def self.included(host_class)
    host_class.extend ClassMethods
  end

  module ClassMethods
    def menu(&block)
      @menu_block ||= block
    end
  end
end
