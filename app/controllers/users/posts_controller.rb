class Users::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def index
    @top_posts = Post.find(Favorite.group(:id).order('count(:id) desc')).limit(5).pluck(:id)
  end

  def new
    @post = Post.new
    @image = @post.photos.build
    @scene = Scene.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      params[:photos]["image"].each do |image|
        @image = @post.photos.create!(image: image)
      end
      redirect_to users_post_path(@post), notice: '投稿完了しました！'
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
      redirect_to users_post_path(@post), notice: '投稿編集完了しました！'
    else
      render :edit
    end
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:post_title, :posted_text, photos_attributes: [:id]).merge(user_id: current_user.id)
  end
end
