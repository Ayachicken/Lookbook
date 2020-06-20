class Users::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to users_user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_user_path(@user), notice: 'プロフィール編集完了しました。'
    else
     render :edit
   end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:nickname,:gender, :age, :introduction, :profile_image, :email, :password)
  end
end
