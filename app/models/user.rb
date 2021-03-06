# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'

  validates :first_name, :last_name, :location, presence: true

  def friends
    friends = []
    friendships.each { |friendship| friends << friendship.friend if friendship.acepted }
    inverse_friendships.each { |friendship| friends << friendship.user if friendship.acepted }
    friends.compact
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

  def search_friends(current_user)
    User.all.map { |user| user unless friend?(user) || current_user == user }.compact
  end

  def self.from_omniauth(auth)
    password = Devise.friendly_token[0, 20]
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = password
      user.password_confirmation = password
      user.first_name = 'Mr '
      user.last_name = auth.info.name
      user.location = 'Unknown'
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
