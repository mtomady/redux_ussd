# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ReduxUssd do
  let(:klass) { (Class.new { include ReduxUssd }) }
  subject { klass.new }

  it 'has a version number' do
    expect(ReduxUssd::VERSION).not_to be nil
  end

  describe '.menu' do
    it 'should setup a menu block' do
      block = proc {}
      klass.menu(&block)
      klass.new
    end
    # let(:menu_block) do
    #   lambda { |_|
    #     screen :screen_1 {}
    #     screen :screen_2 {}
    #   }
    # end
    #
    # it 'should add screens' do
    #   allow(subject).to receive(:add_screen)
    #   subject.menu(&menu_block)
    #   expect(subject).to have_received(:add_screen).with(:screen_1)
    #   expect(subject).to have_received(:add_screen).with(:screen_2)
    # end
  end

  describe '#menu' do
    context 'menu was setup' do
      before(:each) do
        klass.menu {} # Setup an empty menu
        subject.setup_menu
      end

      it 'should return a menu instance' do
        expect(subject.menu).to be_an_instance_of(ReduxUssd::Menu)
      end
    end

    context 'menu was not setup' do
      it 'should return nil' do
        expect(subject.menu).to be_nil
      end
    end
  end

  describe '#setup_menu' do
    before(:each) do
      klass.menu {} # Setup an empty menu
    end

    context 'initial state is given' do
      let(:initial_state) { { some_state: 'test' } }

      it 'should setup the menu with the given state' do
        expect { subject.setup_menu(initial_state) }.to change(subject, :menu)
        expect(subject.menu.state).to eq(initial_state)
      end
    end

    context 'initial state is not given' do
      it 'should setup the menu with the given state' do
        expect { subject.setup_menu }.to change(subject, :menu)
        expect(subject.menu.state).to eq(navigation: {
                                           current_screen: :index, routes: {}
                                         }, prompt: {})
      end
    end

    it 'should evaluate the menu block' do
    end
  end
end
