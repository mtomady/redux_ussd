RSpec.describe ReduxUssd::Reducers::Navigation do
  subject { described_class }

  describe '.call' do
    let(:state) { { current_screen: :old_screen_name, routes: {} } }

    context 'action type is :push' do
      let(:action) { { type: :push, screen: :new_screen_name } }

      it 'should update the :current_screen' do
        expect(subject.call(action, state)).to eq(current_screen: :new_screen_name, :routes=>{})
      end
    end

    context 'action type is not :push' do
      let(:action) { { type: :not_push, screen: :new_screen_name } }

      it 'should not update the :current_screen' do
        expect(subject.call(action, state)).to eq(current_screen: :old_screen_name, :routes=>{})
      end
    end

    context 'action is :register_route' do
      let(:action) { { type: :register_route, screen: :start_screen, target: :end_screen } }

      it 'should not update the routes' do
        expect(subject.call(action, state)).to eq(current_screen: :old_screen_name,
                                                  routes: { start_screen: [:end_screen]})
      end

      context 'routes are existing' do
        let(:state) { { current_screen: :old_screen_name, routes: {start_screen: [:end_screen_one]} } }

        let(:action) { { type: :register_route, screen: :start_screen, target: :end_screen_two } }

        it 'should not update the routes' do
          expect(subject.call(action, state)).to eq(current_screen: :old_screen_name,
                                                    routes: { start_screen: [:end_screen_one, :end_screen_two]})
        end
      end
    end
  end
end
