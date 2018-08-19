# frozen_string_literal: true

require 'spec_helper'
require 'redux_ussd/matchers'

RSpec.describe ReduxUssd::Shoulda::Matchers::UseActionMatcher do
  extend ReduxUssd::Shoulda::Matchers

  let(:store) { spy('ReduxUssd::Store') }
  let(:block) { proc {} }
  let(:action_name) { nil }
  let(:screen) do
    ReduxUssd::Components::Screen.new(name: 'test',
                                      action: action_name,
                                      block: block,
                                      store: store)
  end

  subject { matcher }

  before(:each) do
    screen.render
  end

  context 'has matching action defined' do
    let(:action_name) { nil }

    it { is_expected.to_not accept(screen) }
  end

  context 'has other action defined' do
    let(:action_name) { :other_action }

    it { is_expected.to_not accept(screen) }
  end

  context 'has not action defined' do
    let(:action_name) { :example_action_name }

    it { is_expected.to accept(screen) }
  end

  private

  def matcher
    self.class.use_action(:example_action_name)
  end
end
