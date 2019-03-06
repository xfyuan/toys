require 'rails_helper'

RSpec.describe Order, type: :model do
  before :each do
    @order = build :order
  end

  subject { @order }

  it { should respond_to :total }
  it { should respond_to :user_id }
  it { should be_valid }

  it { should validate_presence_of :total }
  it { should validate_presence_of :user_id }
  it { should validate_numericality_of(:total).is_greater_than_or_equal_to(0) }

  it { should belong_to :user }

  it { should have_many :placements }
  it { should have_many(:toys).through :placements }
end
