require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'Get #show' do
    before :each do
      @user = create :user
      get :show, params: { id: @user.id }
    end

    it { should respond_with 200 }

    it 'returns a user response' do
      json_response = JSON.parse response.body, symbolize_names: true
      expect(json_response[:email]).to eq @user.email
    end
  end
end
