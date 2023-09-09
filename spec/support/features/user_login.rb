# frozen_string_literal: true

module UserLogin
  def admin_sign_in(admin = nil)
    admin ||= FactoryBot.create(:admin)
    visit '/users/sign_in'
    fill_in :user_email, with: admin.email
    fill_in :user_password, with: admin.password
    click_button 'Sign in'
  end

  def user_sign_in(user)
    visit '/users/sign_in'
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    click_button 'Sign in'
  end
end
