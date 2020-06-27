class Admins::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def suspend
    @user = User.find(params[:id])
    if @user.validity == 1
      @user.validity = 0
      @user.save!
      redirect_back(fallback_location: root_path)
    else
      @user.validity = 1
      @user.save!
      redirect_back(fallback_location: root_path)
    end
  end
end
