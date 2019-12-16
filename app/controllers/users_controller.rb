# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit search_friends]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @posts = @user.posts.order(updated_at: :desc)
    @can_request = can_request
  end

  # GET /users/1/edit
  def edit; end

  def search_friends
    @per_confirm_friends = @user.friend_requests.compact
    @per_request_friends = @user.search_friends(@user)
    @can_request = can_request
  end

  def add_friend
    friend = current_user.friendships.build(friend_id: params[:id], acepted: false)
    if friend.save
      redirect_back fallback_location: current_user, notice: 'You requested a frienship!'
    else
      redirect_to current_user, alert: 'You already are friend!'
    end
  rescue StandardError => e
    print e
    redirect_back fallback_location: current_user, alert: 'There was a problem requesting this!'
  end

  def confirm_friend
    friend = User.find(params[:id])
    if current_user.confirm_friend(friend)
      redirect_back fallback_location: current_user, notice: 'You acepted a frienship!'
    else
      redirect_to current_user, alert: 'You can not accept this friend!'
    end
  rescue StandardError => e
    print e
    redirect_back fallback_location: current_user, alert: 'There was a problem requesting this!'
  end

  private

  def can_request
    i_did_not_requested = Friendship.where('friend_id = ? AND user_id = ?', current_user.id, @user.id).none?
    friend_did_not_requested = Friendship.where('friend_id = ? AND user_id = ?', @user.id, current_user.id).none?
    not_current = current_user.id != @user.id
    not_friend = current_user.friend?(@user) == false
    i_did_not_requested && friend_did_not_requested && not_current && not_friend
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :location)
  end
end
