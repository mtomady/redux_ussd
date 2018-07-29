RSpec.describe ReduxUssd::Store do
  let(:middlewares) { [] }
  let(:reducers) { [] }
  let(:listeners) { [] }
  let(:initial_state) { {} }
  let(:store) { described_class.new(initial_state,
                                    reducers,
                                    middlewares,
                                    listeners)}
  subject { store }

  describe '#state' do

  end

  describe '#dispatch' do

  end

end