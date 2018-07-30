
# frozen_string_literal: true

RSpec.describe ReduxUssd::Menu do
  let(:store) { double('ReduxUssd::Store') }
  let(:initial_state) do
    {
      navigation: { current_screen: nil, routes: {} }
    }
  end
  let(:menu) { ReduxUssd::Menu.new(initial_state) }
  subject { menu }

  before(:each) do
    allow(ReduxUssd::Store).to receive(:new).and_return(store)
    allow(store).to receive(:dispatch)
  end

  describe '#add_screen' do
    let(:screen_name) { :new_screen }
    let(:block) { ->(_) {} }

    it 'should add a new screen' do
      screen = subject.add_screen(screen_name, &block)
      expect(screen).to be_instance_of(ReduxUssd::Components::Screen)
    end
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
end
