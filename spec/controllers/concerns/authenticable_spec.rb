require 'rails_helper'

class Authentication < ApplicationController
  include Authenticable
end

RSpec.describe Authenticable do
  let(:authentication) { Authentication.new }
  subject { authentication }

  describe '#current_user' do
    before :each do
      @user = create :user
      request.headers['Authoriziation'] = @user.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end

    it 'returns the user from authorization header' do
      expect(authentication.current_user.auth_token).to eq @user.auth_token
    end
  end
end
