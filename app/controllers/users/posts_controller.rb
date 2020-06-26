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
    @post = Post.new(post_params)
    if @post.save
      params[:photos]["post_image"].each do |image|
        @image = @post.photos.create!(post_image: post_image)
      end
      redirect_to user_post_path(post_id), notice: '投稿完了しました！'
    else
      @post.photos.build
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    if @post = Post.update
      redirect_to user_post_path(post_id), notice: '投稿編集完了しました！'
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:post_title, :posted_text, photos_attributes: [:post_image])
  end
end
