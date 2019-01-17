require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    before :each do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

end
