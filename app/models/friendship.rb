# frozen_string_literal: true

class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :if_friend_with_myself
  validate :if_reverse_request
  validates :user_id, presence: true
  validates :friend_id, presence: true

  def if_friend_with_myself
    return unless friend_id == user_id

    errors.add(:base, 'You can not be friend with youlself, duh!')
  end

  def if_reverse_request
    return unless Friendship.where('user_id = ? AND friend_id = ?', friend_id, user_id).any?

    errors.add(:base, 'That friendship is requested or is already accepted')
  end
end
