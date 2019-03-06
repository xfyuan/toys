require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = build :user
  end

  subject { @user }

  it { should respond_to :email }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :auth_token }
  it { should be_valid }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_uniqueness_of(:auth_token) }
  it { should validate_confirmation_of :password }
  it { should allow_value('example@domain.com').for(:email) }

  it { should have_many :toys }
  it { should have_many :orders }

  describe '#generate_authentication_token!' do
    it 'generate a unique token' do
      allow(Devise).to receive(:friendly_token).and_return('uniquetoken123')
      @user.generate_authentication_token!
      expect(@user.auth_token).to eq 'uniquetoken123'
    end

    it 'generate another token when one already has been taken' do
      existing_user = create :user, auth_token: 'uniquetoken123'
      @user.generate_authentication_token!
      expect(@user.auth_token).not_to eq existing_user.auth_token
    end
  end
end
