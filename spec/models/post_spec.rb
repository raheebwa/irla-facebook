require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should have_db_column(:body) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:body) }
end
