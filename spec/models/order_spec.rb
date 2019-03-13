require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build :order }

  subject { order }

  it { should respond_to :total }
  it { should respond_to :user_id }
  it { should be_valid }

  it { should validate_presence_of :user_id }

  it { should belong_to :user }

  it { should have_many :placements }
  it { should have_many(:toys).through :placements }

  describe '#set_total!' do
    before :each do
      toy1 = create :toy, price: 100
      toy2 = create :toy, price: 85

      @order = build :order, toy_ids: [toy1.id, toy2.id]
    end

    it 'returns the total amount to pay for the toys' do
      expect { @order.set_total! }.to change { order.total }.from(0).to(185)
    end
  end

  describe '#build_placements' do
    before :each do
      toy1 = create :toy, price: 100, quantity: 5
      toy2 = create :toy, price: 85, quantity: 10
      @toy_ids_and_quantities = [[toy1.id, 2], [toy2.id, 3]]
    end

    it 'build 2 placements for the order' do
      expect(order.build_placements(@toy_ids_and_quantities)).to be_present
    end
  end
end
