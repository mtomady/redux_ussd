# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::Option do
  subject { described_class }

  describe '.call' do
    context 'action type is :register_option' do
      let(:action) { { type: :register_option, screen: :some_screen, option: :yes } }

      it 'should add a new option to the state' do
        expect(subject.call(action, state)).to eq(option: :some_option,
                                                  some_screen: [:yes])
      end

      context 'options are existing' do
        let(:state) { { option: :some_option, some_screen: [:yes] } }
        let(:action) { { type: :register_option, screen: :some_screen, option: :no } }

        it 'should append a the option to the state' do
          expect(subject.call(action, state)).not_to eq(option: :some_option,
                                                        some_screen: %i[yes no])
        end
      end

      it 'should not equal the old state' do
        expect(subject.call(action, state)).not_to eq(state)
      end
    end
  end

end