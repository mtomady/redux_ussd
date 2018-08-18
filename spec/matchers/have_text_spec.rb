# frozen_string_literal: true

require 'spec_helper'
require 'redux_ussd/matchers'

RSpec.describe ReduxUssd::Shoulda::Matchers::HaveTextMatcher do
  extend ReduxUssd::Shoulda::Matchers

  let(:store) { spy('ReduxUssd::Store') }
  let(:screen) do
    ReduxUssd::Components::Screen.new(name: 'test',
                                      block: block,
                                      store: store)
  end

  before(:each) do
    screen.render
  end

  subject { matcher }

  context 'has text' do
    let(:block) do
      proc do
        text 'This is text.'
      end
    end

    it { is_expected.to accept(screen) }
  end

  context 'has another text' do
    let(:block) do
      proc do
        text 'This is another text.'
      end
    end

    it { is_expected.not_to accept(screen) }

  end

  private

  def matcher
    self.class.have_text('This is text.')
  end
end
