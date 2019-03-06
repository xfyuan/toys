require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe 'Get #index' do
    before :each do
      current_user = create :user
      api_authorization_header current_user.auth_token
      4.times { create :order, user: current_user }
      get :index, params: { user_id: current_user.id }
    end

    it { should respond_with 200 }

    it 'returns 4 orders from the user' do
      expect(json_response[:data].count).to eq 4
    end
  end
end
