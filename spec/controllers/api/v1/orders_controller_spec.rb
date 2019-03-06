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

  describe 'Get #show' do
    before :each do
      current_user = create :user
      api_authorization_header current_user.auth_token

      @toy = create :toy
      @order = create :order, user: current_user, toy_ids: [@toy.id]
      get :show, params: { user_id: current_user.id, id: @order.id }
    end

    it { should respond_with 200 }

    it 'returns the user order matching the id' do
      expect(json_response[:data][:id].to_i).to eq @order.id
    end

    it 'returns the toys matching the order' do
      toys_response = json_response[:data][:relationships][:toys][:data]
      expect(toys_response).to be_present
      expect(toys_response.count).to eq 1
      expect(toys_response.first[:id].to_i).to eq @toy.id
    end
  end

  describe 'Post #create' do
    context 'when created successfully' do
      before :each do
        current_user = create :user
        api_authorization_header current_user.auth_token

        @toy1 = create :toy
        @toy2 = create :toy
        post :create, params: { user_id: current_user.id, order: { toy_ids: [@toy1.id, @toy2.id] } }
      end

      it { should respond_with 201 }

      it 'returns the user order record' do
        expect(json_response[:data]).to be_present
      end
    end
  end
end
