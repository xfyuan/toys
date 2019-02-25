require 'rails_helper'

RSpec.describe Api::V1::ToysController, type: :controller do
  describe "Get #show" do
    before :each do
      @toy = create :toy
      get :show, params: { id: @toy.id }
    end

    it { should respond_with 200 }

    it 'returns a toy record' do
      expect(json_response[:data][:attributes][:title]).to eq @toy.title
    end
  end

  describe "Get #index" do
    before :each do
      4.times { create :toy }
      get :index
    end

    it { should respond_with 200 }

    it 'returns 4 toy records' do
      expect(json_response[:data].count).to eq 4
    end
  end

  describe "Post #create" do
    context 'when successfully created' do
      before :each do
        user = create :user
        @toy_attributes = attributes_for :toy
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, toy: @toy_attributes }
      end

      it { should respond_with 201 }

      it 'renders the json for the toy record just created' do
        toy_response = json_response
        expect(toy_response[:data][:attributes][:title]).to eq @toy_attributes[:title]
      end
    end

    context 'when not created' do
      before :each do
        user = create :user
        @invalid_toy_attributes = { title: 'smart tv', price: ' 12 yuan' }
        api_authorization_header user.auth_token
        post :create, params: { user_id: user.id, toy: @invalid_toy_attributes }
      end

      it { should respond_with 422 }

      it 'renders an errors json' do
        toy_response = json_response
        expect(toy_response).to have_key(:errors)
      end

      it 'renders why the user could not be created' do
        toy_response = json_response
        expect(toy_response[:errors].first[:detail]).to include 'is not a number'
      end
    end
  end

  describe 'Put #update' do
    before :each do
      @user = create :user
      @toy = create :toy, user: @user
      api_authorization_header @user.auth_token
    end

    context 'when successfully updated' do
      before :each do
        patch :update, params: { user_id: @user.id, id: @toy.id, toy: { title: 'smart tv 2 generation' } }
      end

      it { should respond_with 200 }

      it 'renders the json for the updated user' do
        toy_response = json_response
        expect(toy_response[:data][:attributes][:title]).to eq 'smart tv 2 generation'
      end
    end

    context 'when not updated' do
      before :each do
        patch :update, params: { user_id: @user.id, id: @toy.id, toy: { price: 'two hundred' } }
      end

      it { should respond_with 422 }

      it 'renders errors json' do
        toy_response = json_response
        expect(toy_response).to have_key(:errors)
      end

      it 'renders the json why the user could not be created' do
        toy_response = json_response
        expect(toy_response[:errors].first[:detail]).to include 'is not a number'
      end
    end
  end

  describe 'Delete #destroy' do
    before :each do
      @user = create :user
      @toy = create :toy, user: @user
      api_authorization_header @user.auth_token
      delete :destroy, params: { user_id: @user.id, id: @toy.id }
    end

    it { should respond_with 204 }
  end
end
