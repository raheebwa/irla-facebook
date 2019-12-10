# frozen_string_literal: true

class Like < ApplicationRecord
  scope :from_post, ->(post_id) { where post_id: post_id }
  scope :from_user, ->(user_id) { where user_id: user_id }

  belongs_to :user
  belongs_to :post
end
