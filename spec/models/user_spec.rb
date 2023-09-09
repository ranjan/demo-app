# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Owner, type: :model do
  subject do
    described_class.new(email: "#{Time.now.to_i}@gmail.com", password: 'Ab@123456789123')
  end

  it 'is valid' do
    expect(subject).to be_valid
  end

  it 'type must be owner ' do
    expect(subject).to be_valid
  end
end
