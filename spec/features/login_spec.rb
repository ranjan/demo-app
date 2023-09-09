# frozen_string_literal: true

require 'rails_helper'
feature 'Login' do
  before(:all) do
    @tenant = FactoryBot.create(:tenant)
  end

  scenario 'Sign in to Admin Portal' do
    admin_sign_in
    expect(page).to have_content 'Site Administration'
    click_link 'Log out'
  end

  scenario 'Sign in to Tenant Portal' do
    user_sign_in(@tenant)
    expect(page).to have_content 'Signed in successfully.'
  end

  scenario 'Sign in to Owner Portal' do
    @user = FactoryBot.create(:owner)
    user_sign_in(@user)
    expect(page).to have_content 'Signed in successfully.'
  end
end
