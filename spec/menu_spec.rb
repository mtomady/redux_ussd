
RSpec.describe ReduxUssd::Menu do
  let(:store) { double('ReduxUssd::Store') }
  let(:menu) { ReduxUssd::Menu.new }
  subject { menu }

  before(:each) do
    allow(ReduxUssd::Store).to receive(:new).and_return(store)
    allow(store).to receive(:dispatch)
  end

  describe '#add_screen' do
    let(:name) { :new_screen }
    let(:block) { lambda { |_| } }

    # it 'should add a new screen' do
    #   subject.add_screen(:new_screen, &block)
    #   subject.screens
    # end
  end

  describe '#render' do
    let(:screen) { double('ReduxUssd::Screen') }

    it 'should render the current screen' do
      expect(subject.render).to eq(screen.render)
    end
  end

  describe '#handle_raw_input' do
    let(:raw_input) { 'a random text'}

    it 'should dispatch :handle_raw_input action' do
      subject.handle_raw_input(raw_input)
      expect(store).to have_received(:dispatch).with(type: :handle_raw_input,
                                                     raw_input: raw_input)
    end
  end

  describe '#state' do
    let(:state) { {var: '1'} }

    it 'should return the stores state' do
      allow(store).to receive(:state).and_return(state)
      expect(subject.state).to eq(state)
      expect(store).to have_received(:state).once
    end
  end
end