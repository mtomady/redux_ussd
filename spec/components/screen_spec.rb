# frozen_string_literal: true

require 'redux_ussd/components/text'

RSpec.describe ReduxUssd::Components::Screen do
  let(:name) { :welcome_screen }
  let(:store) { double('ReduxUssd::Store') }
  let(:component_block) { proc {} }
  let(:action) { :example_action_name }
  let(:screen) do
    described_class.new(name: name,
                        store: store,
                        action: action,
                        block: component_block)
  end

  subject { screen }

  describe '#action' do
    it 'should return the initialized action' do
      expect(subject.action).to eq(action)
    end
  end

  describe '#action?' do
    context 'was initialized with action' do
      it 'should return true' do
        expect(subject.action?).to be_truthy
      end
    end

    context 'was not initialized with action' do
      let(:screen) do
        described_class.new(name: name,
                            store: store,
                            block: component_block)
      end

      it 'should return false' do
        expect(subject.action?).to be_falsey
      end
    end
  end

  describe '#render' do
    context 'with multiple components' do
      let(:component_block) do
        proc do
          text 'hello'
          text 'world'
        end
      end

      it 'should render each component by a new line' do
        expect(subject.render).to eq("hello\nworld")
      end
    end

    context 'with prompt component' do
      before(:each) do
        allow(store).to receive(:dispatch)
      end

      let(:component_block) do
        proc do
          prompt :hello_key, text: 'some text'
        end
      end

      it 'should render the text' do
        expect(subject.render).to eq('some text')
      end

      it 'should dispatch a :register_prompt action' do
        subject.render
        expect(store).to have_received(:dispatch).with(type: :register_prompt,
                                                       screen: name,
                                                       target: :hello_key)
      end
    end

    context 'with option components' do
      before(:each) do
        allow(store).to receive(:dispatch)
      end

      let(:component_block) do
        proc do
          option :option_1, text: 'hello'
          option :option_2, text: 'world'
        end
      end

      it 'should render each option text as numbered list' do
        expect(subject.render).to eq("1. hello\n2. world")
      end

      it 'should dispatch :register_prompt actions' do
        subject.render
        expect(store).to have_received(:dispatch).with(type: :register_option,
                                                       screen: :welcome_screen,
                                                       option: :option_1)
        expect(store).to have_received(:dispatch).with(type: :register_option,
                                                       screen: :welcome_screen,
                                                       option: :option_2)
      end
    end
  end
end
