require 'rails_helper'

RSpec.describe Placement, type: :model do
  let(:placement) { build :placement }

  subject { placement }

  it { should respond_to :order_id }
  it { should respond_to :toy_id }
  it { should respond_to :quantity }

  it { should belong_to :order }
  it { should belong_to :toy }

  describe '#decrement_toy_quantity!' do
    it 'decrease the toy quantity by placement quantity' do
      toy = placement.toy
      expect { placement.decrement_toy_quantity! }.to change { toy.quantity }.by(-placement.quantity)
    end
  end
end
