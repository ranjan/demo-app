# frozen_string_literal: true

module ControllerMacros
  def login_admin
    @request.env['devise.mapping'] = Devise.mappings[:admin]
    sign_in FactoryBot.create(:admin)
  end

  def login_tenant
    tenant = FactoryBot.create(:tenant)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in tenant
  end
end
