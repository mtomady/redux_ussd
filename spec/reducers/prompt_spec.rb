# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::Prompt do
  subject { described_class }

  describe '.call' do
    let(:state) { { targets: { some_target: :some_value_key }, values: { some_value_key: nil } } }


    context 'action type is :register_prompt' do
      let(:action) { { type: :register_prompt, target: :some_target, screen: :the_current_screen } }

      it 'should update the :target' do
        expect(subject.call(action, state)).to eq(targets: { the_current_screen: :some_target },
                                                  values: {})
        # TODO: test deep merge
      end

      context 'with existing values' do
      end
    end

    context 'action type is other' do
      let(:action) { { type: :something, screen: :new_screen_name } }

      it 'should equal the initial state' do
        expect(subject.call(action, state)).to eq(state)
      end
    end
  end
end
