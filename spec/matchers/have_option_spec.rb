# frozen_string_literal: true

require 'spec_helper'
require 'redux_ussd/matchers'

RSpec.describe ReduxUssd::Shoulda::Matchers::HaveOptionMatcher do
  extend ReduxUssd::Shoulda::Matchers

  let(:store) { spy('ReduxUssd::Store') }
  let(:screen) do
    ReduxUssd::Components::Screen.new(name: 'test',
                                      block: block,
                                      store: store)
  end

  subject { matcher }

  # TODO: Test with position
  before(:each) do
    screen.render
  end

  context 'having a option with name and text' do
    let(:block) do
      proc do
        option :name, text: 'This is text.'
      end
    end

    it { is_expected.to accept(screen) }
  end

  context 'having options with other names' do
    let(:block) do
      proc do
        option :other_name, text: 'This is text.'
      end
    end

    it { is_expected.not_to accept(screen) }
  end

  context 'having options with other names' do
    let(:block) do
      proc do
        option :name, text: 'This is a another text.'
      end
    end

    it { is_expected.not_to accept(screen) }
  end

  context 'having no options' do
    let(:block) do
      proc {}
    end

    it { is_expected.not_to accept(screen) }
  end

  private

  def matcher
    self.class.have_option_component(:name, 'This is text.')
  end
end
