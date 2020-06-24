class Users::RelationshipsController < ApplicationController
  def followed
    current_user.followed(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following_user
    render 'users/relationships/following'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user
    render 'users/relationships/follower'
  end
end
