class Admins::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def suspend
    @user = User.find(params[:id])
    if @user.validity == 'Valid'
      @user.validity = 'Invalid'
      @user.save!
      redirect_back(fallback_location: root_path)
    else
      @user.validity = 'Valid'
      @user.save!
      redirect_back(fallback_location: root_path)
    end
  end
end
