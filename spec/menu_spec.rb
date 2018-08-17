
# frozen_string_literal: true

RSpec.describe ReduxUssd::Menu do
  let(:store) { double('ReduxUssd::Store') }
  let(:initial_state) { ReduxUssd.initial_state }
  let(:session) { { msisdn: '+491111111111' } }
  let(:menu) do
    ReduxUssd::Menu.new(session: session,
                        state: initial_state)
  end
  subject { menu }

  before(:each) do
    allow(ReduxUssd::Store).to receive(:new).and_return(store)
    allow(store).to receive(:dispatch)
  end

  describe '#register_screen' do
    let(:screen_name) { :new_screen }
    let(:screen_block) { proc {} }

    it 'should add a new screen' do
      expect do
        subject.register_screen(screen_name, &block)
      end.to change { subject.screens.count }.by(1)
    end

    it 'should register a screen with given properties' do
      subject.register_screen(screen_name, &block)
      expect(subject.screens[screen_name]).to be_instance_of(ReduxUssd::Components::Screen)
      expect(subject.screens[screen_name]).to have_attributes
    end

    # TODO: Assert properties
  end

  describe '#register_action' do
    let(:action_name) { :example_action_name }
    let(:action_block) { proc {} }

    it 'should add a new action to #actions' do
      expect do
        subject.register_action :action_name, &action_block
      end.to change { subject.actions.count }.by(1)
    end
    # TODO: Assert properties
  end

  describe '#render' do
    let(:screen_content) { 'This is example render' }
    let(:screen) { double('ReduxUssd::Screen') }
    let(:screen_name) { :example_screen_name }

    before(:each) do
      allow(store).to receive_message_chain(:state, :[], :[])
        .with(:current_screen).and_return(screen_name)
      allow(subject).to receive(:screens).and_return(screen_name => screen)
      allow(screen).to receive(:render).and_return(screen_content)
    end

    it 'should render the current screen' do
      expect(subject.render).to eq(screen_content)
      expect(screen).to have_received(:render).once
    end
  end

  describe '#handle_raw_input' do
    let(:raw_input) { 'a random text' }

    it 'should dispatch :handle_raw_input action' do
      subject.handle_raw_input(raw_input)
      expect(store).to have_received(:dispatch)
        .with(type: :handle_raw_input, raw_input: raw_input)
    end
  end

  describe '#state' do
    let(:state) { { var: '1' } }

    it 'should return the stores state' do
      allow(store).to receive(:state).and_return(state)
      expect(subject.state).to eq(state)
      expect(store).to have_received(:state).once
    end
  end

  describe '#check_end?' do
    context 'no prompts or options in current screen' do
      before(:each) do
        allow(store).to receive_message_chain(:screens, :[], :prompt_or_options?).and_return(false)
      end

      it 'should dispatch a :force_end action' do
        expect(subject.check_end?).to be_truthy
        expect(store).to have_received(:dispatch).with(type: :force_end)
      end
    end

    context 'store state for :end is true' do
      before(:each) do
        allow(store).to receive_message_chain(:state, :[])
          .with(:navigation)
          .and_return(:index)
        allow(store).to receive_message_chain(:state, :[])
          .with(:end)
          .and_return(true)
      end

      it 'should return true' do
        expect(subject.check_end?).to be_truthy
      end
    end

    context 'store state for :end is false' do
      before(:each) do
        allow(store).to receive_message_chain(:state, :[])
          .with(:navigation)
          .and_return(:index)
        allow(store).to receive_message_chain(:state, :[])
          .with(:end)
          .and_return(false)
      end

      it 'should return false' do
        expect(subject.check_end?).to be_falsey
      end
    end
  end

  describe '#session' do
    it 'should equal the passed session' do
      expect(subject.session).to eq(session)
    end
  end

  describe '#state' do
    let(:store_state) do
      { this_is_state: true }
    end

    before(:each) do
      allow(store).to receive(:state).and_return(store_state)
    end

    it 'should return the store state' do
      expect(subject.state).to eq(store_state)
      expect(store.state).to have_received(:state).once
    end
  end

  describe '#actions' do
  end

  describe '#screens' do
  end
end
