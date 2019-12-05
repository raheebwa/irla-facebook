require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :post => "",
      :user => "",
      :body => "MyText",
      :image_path => "MyString"
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input[name=?]", "comment[post]"

      assert_select "input[name=?]", "comment[user]"

      assert_select "textarea[name=?]", "comment[body]"

      assert_select "input[name=?]", "comment[image_path]"
    end
  end
end
