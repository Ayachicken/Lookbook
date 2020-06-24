class Users::PostsController < ApplicationController
  def show
  end

  def index
  end

  def new
    @post = Post.new
    @post.photos.build
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
