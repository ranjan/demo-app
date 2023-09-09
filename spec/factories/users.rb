# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'USER' }
    sequence(:email) { |n| "email#{n}@tenantscoop" }
    password { 'Testing@12345' }
    password_confirmation { 'Testing@12345' }
  end
  factory :owner do
    name { 'OWNER' }
    sequence(:email) { |n| "owner#{n}@tenantscoop" }
    type { 'Owner' }
    password { 'Testing@12345' }
    password_confirmation { 'Testing@12345' }
  end
  factory :tenant do
    name { 'TENANT' }
    sequence(:email) { |n| "tenant#{n}@tenantscoop" }
    type { 'Tenant' }
    password { 'Testing@12345' }
    password_confirmation { 'Testing@12345' }
  end
  factory :admin do
    name { 'ADMIN' }
    email { 'admin@tenantscoop' }
    type { 'Admin' }
    password { 'Testing@12345' }
    password_confirmation { 'Testing@12345' }
  end
end
