
RSpec.describe ReduxUssd::Menu do
  let(:store) { double('ReduxUssd::Store') }
  let(:menu) { ReduxUssd::Menu.new }
  subject { menu }

  before(:each) do
    allow(subject).to receive(:store).and_return(store)
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
    it 'should render the current screen' do

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

  # def screen(name, _options = {}, &block)
  #   screens[name] = Components::Screen.new(
  #       name: name,
  #       store: store,
  #       block: block
  #   )
  # end
  #
  # def render
  #   current_screen = store.state[:navigation][:current_screen]
  #   screens[current_screen].tap do |screen|
  #     instance_eval(&screen.process_block)
  #   end.render
  # end
  #
  # def handle_raw_input(raw_input)
  #   store.dispatch(type: :handle_raw_input, raw_input: raw_input)
  # end
  #
  # def end?
  #   current_screen = store.state[:navigation][:current_screen]
  #   store.state[:navigation][:routes][current_screen].empty?
  # end
  #
  # # def will_mount
  # #   return unless @process_block
  # #   @store.unsubscribe(@process_block)
  # # end
  # #
  # # def will_unmount
  # #   return unless @process_block
  # #   @store.subscribe do
  # #     @process_block.call(@store.state)
  # #   end
  # # end
  # #
  #
  # def state
  #   @store.state
  # end
end