require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should have_db_column(:body) }
  it { should have_db_column(:image_path) }
  it { should belong_to(:user) }
  it { should belong_to(:post) }
  it { should validate_presence_of(:body) }
end
