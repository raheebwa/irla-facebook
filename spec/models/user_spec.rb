require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_uniqueness_of(:email)}
  it { should have_db_column(:first_name) }
  it { should have_db_column(:last_name) }
  it { should have_db_column(:location) }
  it { should have_db_column(:gravatar) }
  it do
    should validate_length_of(:password).
    is_at_least(6)
  end
end