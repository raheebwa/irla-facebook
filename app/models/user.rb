# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :first_name, :last_name, :location, presence: true

  def friends
    friends_array = friendships.map { |friendship| friendship.friend if friendship.acepted }
    friends_array.compact + inverse_friendships.map { |friendship| friendship.user if friendship.acepted }
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |friendship| friendship.friend unless friendship.acepted }.compact
  end

  def unnacepted_friend_requests
    friends = []
    inverse_friendships.each { |request| friends << request.user unless request.acepted }
    friends
  end

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |friendship| friendship.user unless friendship.acepted }.compact
  end

  def confirm_friend(user)
    friendship = inverse_friendships.find { |friend| friend.user == user }
    friendship.acepted = true
    friendship.save
  end

  def friend?(user)
    friends.include?(user)
  end
end
