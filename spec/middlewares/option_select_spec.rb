# frozen_string_literal: true

RSpec.describe ReduxUssd::Middlewares::OptionSelect do
  subject { described_class }

  let(:store) { double('ReduxUssd::Store') }

  let(:state) do
    {
      options: {

      },
      navigation: {
        current_screen: :welcome
      }
    }
  end

  describe '.call' do
    before(:each) do
      allow(store).to receive(:state).and_return(state)
      allow(store).to receive(:dispatch)
    end

    let(:action) do
      { type: :handle_raw_input,
        raw_input: '1' }
    end

    let(:forward_error) { StandardError.new('This should not be raised') }
    let(:forward) { proc { raise forward_error } }

    context 'action type is :handle_raw_input' do
      context 'options are existing' do
        let(:state) do
          {
            options: { current_screen: %i[yes no] },
            navigation: { current_screen: :welcome }
          }
        end

        let(:action) do
          { type: :handle_raw_input,
            raw_input: '1' }
        end

        it 'should not dispatch a :select_option action' do
          subject.call(store).call(forward).call(action)
          expect(store).to have_received(:dispatch).with(type: :select_option,
                                                         screen: :welcome,
                                                         option: :yes)
        end

        it 'should not update the store state' do
          expect { subject.call(store).call(forward).call(action) }.not_to change(store, :state)
        end
      end

      context 'no option exists' do
        let(:state) do
          {
            options: {},
            navigation: { current_screen: :welcome }
          }
        end

        it 'should not dispatch a :select_option action' do
          subject.call(store).call(forward).call(action)
          expect(store).not_to have_receive(:dispatch).with(type: :select_option, screen: current_screen,
                                                            option: option)
        end

        it 'should not update the store state' do
          subject.call(store).call(forward).call(action)
          expect { subject.call(store).call(forward).call(action) }.not_to change(store, :state)
        end
      end

      context 'raw input cannot be interpreted as an integer' do
        let(:action) do
          { type: :handle_raw_input,
            raw_input: 'other' }
        end

        it 'should not dispatch a :select_option action' do
          subject.call(store).call(forward).call(action)
          expect(store).not_to have_receive(:dispatch).with(type: :select_option, screen: current_screen,
                                                            option: option)
        end

        it 'should not update the store state' do
          expect { subject.call(store).call(forward).call(action) }.not_to change(store, :state)
        end
      end
    end

    context 'receives another action' do
      let(:action) { { type: :another_action } }

      it 'forward the action to defined block' do
        expect do
          subject.call(store).call(forward).call(action)
        end.to raise_error(forward_error)
      end
    end
  end
end
