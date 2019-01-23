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

  describe 'Post #create' do
    context 'when created successfully' do
      before :each do
        @user_attributes = attributes_for :user
        post :create, params: { user: @user_attributes }
      end

      it { should respond_with 201 }

      it 'returns the user record just created' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:email]).to eq @user_attributes[:email]
      end
    end

    context 'when created failed' do
      before :each do
        @invalid_user_attributes = { password: '123456', password_confirmation: '123456' }
        post :create, params: { user: @invalid_user_attributes }
      end

      it { should respond_with 422 }

      it 'render errors json' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response).to have_key(:errors)
      end

      it 'render errors json with details message' do
        json_response = JSON.parse response.body, symbolize_names: true
        expect(json_response[:errors][:email]).to include("can't be blank")
      end
    end
  end
end
