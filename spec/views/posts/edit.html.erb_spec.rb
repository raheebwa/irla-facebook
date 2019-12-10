# require 'rails_helper'

# RSpec.describe "posts/edit", type: :view do
#   before(:each) do
#     @user = User.create({email: "foo@bar.com", password: "foobar", password_confirmation: "foobar"})
#     @post = assign(:post, Post.create!(
#       :user_id => @user.id,
#       :body => "MyText"
#     ))
#   end

#   it "renders the edit post form" do
#     render

#     assert_select "form[action=?][method=?]", post_path(@post), "post" do

#       assert_select "textarea[name=?]", "post[body]"
#     end
#   end
# end
