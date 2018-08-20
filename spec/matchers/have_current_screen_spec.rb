# frozen_string_literal: true

require 'spec_helper'
require 'redux_ussd/matchers'

RSpec.describe ReduxUssd::Shoulda::Matchers::HaveCurrentScreenMatcher do
  extend ReduxUssd::Shoulda::Matchers

  let(:state) do
    state = ReduxUssd.initial_state
    state[:navigation][:current] = screen_name
    state
  end

  let(:menu) do
    ReduxUssd::Menu.new(static: {},
                        state: state)
  end
  subject { matcher }

  context 'current screen is :example_name' do
    let(:screen_name) do
      :example_name
    end

    it { is_expected.to accept(menu) }
  end

  context 'current screen is :other_screen' do
    let(:screen_name) do
      :other_screen
    end

    it { is_expected.not_to accept(menu) }
  end

  let(:matcher) do
    self.class.have_current_screen(:example_name)
  end
end
