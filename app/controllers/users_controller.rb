# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @posts = @user.posts.order(updated_at: :desc)
    @posts
  end

  # GET /users/1/edit
  def edit; end

  def add_friend
    friend = current_user.friendships.build(friend_id: params[:id], acepted: false)
    if friend.save
      redirect_back fallback_location: @user, notice: 'You requested a frienship!'
    else
      redirect_to @user, alert: 'You already are friend!'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :location)
  end
end
