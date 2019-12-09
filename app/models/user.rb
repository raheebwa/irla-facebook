# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes
  # has_many :liked_posts, through: :likes, source: :post

  validates :first_name, :last_name, :location, presence: true

  # def self.name(user)
  #   "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  # end
end
