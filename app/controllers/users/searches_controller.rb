class Users::SearchesController < ApplicationController
  def search
    @user_or_post = params[:option]
    @content = params[:search]
    if @user_or_post == '1'
      @users = User.search(params[:search], @user_or_post)
    elsif @user_or_post == '2'
      @posts = Post.search(params[:search], @user_or_post)
    else
      render '/'
    end
  end
end
