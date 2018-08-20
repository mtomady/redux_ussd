# frozen_string_literal: true

require 'spec_helper'
require 'redux_ussd/matchers'

RSpec.describe ReduxUssd::Shoulda::Matchers::HavePromptMatcher do
  extend ReduxUssd::Shoulda::Matchers

  let(:store) { spy('ReduxUssd::Store') }
  let(:screen) do
    ReduxUssd::Components::Screen.new(name: 'test',
                                      block: block,
                                      store: store)
  end

  let(:matcher) do
    self.class.have_prompt_component(:name, 'This is text.')
  end

  subject { matcher }

  before(:each) do
    screen.render
  end

  context 'having a prompt with name and text' do
    let(:block) do
      proc do
        prompt :name, text: 'This is text.'
      end
    end

    it { is_expected.to accept(screen) }
  end

  context 'having prompt with other name' do
    let(:block) do
      proc do
        prompt :other_name, text: 'This is text.'
      end
    end

    it { is_expected.not_to accept(screen) }
  end

  context 'having prompt with other text' do
    let(:block) do
      proc do
        prompt :name, text: 'This is a another text.'
      end
    end

    it { is_expected.not_to accept(screen) }
  end

  context 'having no prompt' do
    let(:block) do
      proc {}
    end

    it { is_expected.not_to accept(screen) }
  end
end
