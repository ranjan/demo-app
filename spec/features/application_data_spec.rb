# frozen_string_literal: true

require 'rails_helper'
feature 'Application Data' do
  before(:all) do
    @tenant = FactoryBot.create(:tenant)
  end

  scenario 'Sign in to Tenant Portal' do
    user_sign_in(@tenant)
    expect(page).to have_content 'Signed in successfully.'
    click_link('Applicaton Wizard')
    expect(page).to have_content 'Upgrade your Account'
    save_and_open_page
  end

end
