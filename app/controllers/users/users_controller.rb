class Users::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def index
    @top_users = User.find(Relationship.group(:follow_id).order('count(follower_id) desc').limit(6).pluck(:follow_id))
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
      @user = User.find(params[:id])
      redirect_to users_user_path(@user), notice: 'プロフィール編集完了しました。'
    else
     render :edit
   end
  end

  def destroy
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :gender, :age, :introduction, :profile_image, :email, :password)
  end
end
