require 'rails_helper'

RSpec.describe Toy, type: :model do
  before :each do
    @toy = build :toy
  end

  subject { @toy }

  it { should respond_to :title }
  it { should respond_to :price }
  it { should respond_to :published }
  it { should respond_to :user_id }
  # it { should be_valid }

  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_presence_of :user_id }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }

  it { should belong_to :user }
  it { should have_many :placements }
  it { should have_many(:orders).through :placements }

  describe 'when search toy title by scope filter_by_title' do
    before :each do
      @toy1 = create :toy, title: 'Ruby boy'
      @toy2 = create :toy, title: 'Elixir girl'
      @toy3 = create :toy, title: 'Redis man'
      @toy4 = create :toy, title: 'Ruby on Rails superman'
    end

    it 'returns correct toys matching' do
      expect(Toy.filter_by_title('Ruby')).to match_array([@toy1, @toy4])
    end
  end

  describe 'when search toy price by scope' do
    before :each do
      @toy1 = create :toy, price: 100
      @toy2 = create :toy, price: 50
      @toy3 = create :toy, price: 150
      @toy4 = create :toy, price: 99
    end

    it 'returns toys which are above or equal to the price' do
      expect(Toy.above_or_equal_to_price(100)).to match_array([@toy1, @toy3])
    end

    it 'returns toys which are below or equal to the price' do
      expect(Toy.below_or_equal_to_price(99)).to match_array([@toy2, @toy4])
    end
  end

  describe 'when get recent toys by scope' do
    before :each do
      @toy1 = create :toy, price: 100
      @toy2 = create :toy, price: 50
      @toy3 = create :toy, price: 150
      @toy4 = create :toy, price: 99
      @toy2.touch
      @toy3.touch
    end

    it 'returns recent updated toys' do
      expect(Toy.recent).to match_array([@toy3, @toy2, @toy4, @toy1])
    end
  end

  describe '#search' do
    before :each do
      @toy1 = create :toy, price: 100, title: 'Ruby boy'
      @toy2 = create :toy, price: 50, title: 'Elixir girl'
      @toy3 = create :toy, price: 150, title: 'Redis man'
      @toy4 = create :toy, price: 99, title: 'Ruby on Rails superman'
    end

    it 'when no condition matches' do
      search_hash = { keyword: 'Ruby', min_price: 150 }
      expect(Toy.search(search_hash)).to be_empty
    end

    it 'when match 2 search params' do
      search_hash = { keyword: 'Ruby', min_price: 100 }
      expect(Toy.search(search_hash)).to match_array([@toy1])
    end

    it 'when match 3 search params' do
      search_hash = { keyword: 'Ruby', min_price: 60, max_price: 180 }
      expect(Toy.search(search_hash)).to match_array([@toy4, @toy1])
    end

    it 'when no params' do
      expect(Toy.search).to match_array([@toy4, @toy3, @toy2, @toy1])
    end
  end
end
