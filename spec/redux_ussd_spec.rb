require 'spec_helper'

RSpec.describe ReduxUssd do
  it 'has a version number' do
    expect(ReduxUssd::VERSION).not_to be nil
  end

  describe '.menu' do
    let(:klass) { (Class.new { include ReduxUssd }) }

    it 'should setup a menu block' do
      block = proc {  }
      klass.menu(&block)
      klass.new
    end
      # let(:menu_block) do
      #   lambda { |_|
      #     screen :screen_1 {}
      #     screen :screen_2 {}
      #   }
      # end
      #
      # it 'should add screens' do
      #   allow(subject).to receive(:add_screen)
      #   subject.menu(&menu_block)
      #   expect(subject).to have_received(:add_screen).with(:screen_1)
      #   expect(subject).to have_received(:add_screen).with(:screen_2)
      # end
  end
end
