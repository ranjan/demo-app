# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  let!(:tenant) { FactoryBot.create(:tenant) }

  describe 'GET #index' do
    context 'signing in a registered user' do
      before do
        sign_in tenant
      end

      it 'should have a current_user' do
        expect(subject.current_user).to_not eq(nil)
      end

      it 'should be signed in' do
        expect(subject.user_signed_in?).to be true
      end
    end

    context 'Dashboard' do
      before do
        login_tenant
      end

      it 'returns a success response for tenants' do
        get :index
        expect(response).to be_successful
      end
    end
  end
end
