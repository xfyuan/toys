require 'rails_helper'

RSpec.describe Placement, type: :model do
  before :each do
    @placement = build :placement
  end

  subject { @placement }

  it { should respond_to :order_id }
  it { should respond_to :toy_id }

  it { should belong_to :order }
  it { should belong_to :toy }
end
