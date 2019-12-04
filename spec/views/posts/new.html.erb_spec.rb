# require 'rails_helper'

# RSpec.describe "posts/new", type: :view do
#   before(:each) do
#     @user = User.create({email: "foo@bar.com", password: "foobar", password_confirmation: "foobar"})
#     assign(:post, Post.new(

#       :user_id => @user.id,
#       :body => "MyText"
#     ))
#   end

#   it "renders new post form" do
#     render

#     assert_select "form[action=?][method=?]", posts_path, "post" do

#       assert_select "textarea[name=?]", "post[body]"
#     end
#   end
# end
