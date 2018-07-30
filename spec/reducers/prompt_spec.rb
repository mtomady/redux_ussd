# frozen_string_literal: true

RSpec.describe ReduxUssd::Reducers::Prompt do
  subject { described_class }

  describe '.call' do
    let(:state) { { target: :a_target, values: {} } }

    context 'action type is :set_prompt_value' do
      let(:action) { { type: :set_prompt_value, value: 'raw input' } }

      it 'should update the target values' do
        expect(subject.call(action, state)).to eq(target: :a_target,
                                                  values: {
                                                    a_target: 'raw input'
                                                  })
      end

      context 'with existing values' do
        it 'should not replace other values' do
        end

        it 'should replace old values' do
        end
      end
    end

    context 'action type is :register_prompt' do
      let(:action) { { type: :register_prompt, target: :some_target } }

      it 'should update the :target' do
        expect(subject.call(action, state)).to eq(target: :some_target,
                                                  values: {})
        expect(subject.call(action, state)).not_to eq(target: :other_target,
                                                      values: {})
      end
    end

    context 'action type is other' do
      let(:action) { { type: :something, screen: :new_screen_name } }

      it 'should not update the state' do
        expect(subject.call(action, state)).to eq(target: :a_target,
                                                  values: {})
      end
    end
  end
end
