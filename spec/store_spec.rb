# frozen_string_literal: true

RSpec.describe ReduxUssd::Store do
  let(:middlewares) { [] }
  let(:reducers) { [] }
  let(:listeners) { [] }
  let(:initial_state) { {} }
  let(:store) do
    described_class.new(initial_state,
                        middlewares,
                        reducers,
                        listeners)
  end
  subject { store }

  describe '#state' do
  end

  describe '#dispatch' do
    let(:reducers) do
      { type_1: proc {}, type_2: proc {}}
    end

    describe 'middlewares' do
      context 'first middleware forwards' do

        let(:middlewares) do
          [MiddlewareMock.new(true),
           MiddlewareMock.new]
        end

        it 'should call both middlewares' do
          subject.dispatch(type: :test)
          expect(middlewares[0]).to have_received(:call)
          expect(middlewares[1]).to have_received(:call)
        end
      end

      context 'first middleware does not forward' do
        let(:middlewares) do
          [MiddlewareMock.new(true),
           MiddlewareMock.new]
        end

        it 'should only call the first middleware' do
          subject.dispatch(type: :test)
          expect(middlewares[0]).to have_received(:call)
          expect(middlewares[1]).not_to have_received(:call)
        end
      end
    end


    it 'should call the reducers' do

    end

    context 'new state is nil' do
      before(:each) do
        allow(subject).to receive(:reduce).and_return(nil)
      end

      it 'should not update the state' do
        expect { subject.dispatch(type: :push) }.to_not change(store, :state)
        expect(subject.state).not_to be_nil
      end

      it 'should not call all subscribers' do
        error = StandardError.new
        store.subscribe do
          raise error
        end
        expect { store.dispatch }.not_to raise_error(error)
      end
    end

    context 'new state is not nil' do
      let(:new_state) { { state: '1' } }

      before(:each) do
        allow(subject).to receive(:reduce).and_return(new_state)
      end

      it 'should call all subscribers' do
        error = StandardError.new
        store.subscribe do
          raise error
        end
        expect { store.dispatch }.to raise_error(error)
      end

      it 'should update the state' do
        expect do
          subject.dispatch(type: :push)
        end.to change { store.state }.to(new_state)
      end
    end
  end
end
