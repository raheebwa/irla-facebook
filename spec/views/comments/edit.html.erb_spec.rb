require 'rails_helper'

RSpec.describe "comments/edit", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :post => "",
      :user => "",
      :body => "MyText",
      :image_path => "MyString"
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input[name=?]", "comment[post]"

      assert_select "input[name=?]", "comment[user]"

      assert_select "textarea[name=?]", "comment[body]"

      assert_select "input[name=?]", "comment[image_path]"
    end
  end
end
