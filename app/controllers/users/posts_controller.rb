class Users::PostsController < ApplicationController
before_action :set_scenes, only:[:new, :create, :edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def index
    @top_posts = Post.find(Favorite.group(:id).order('count(:id) desc')).limit(5).pluck(:id)
  end

  def new
    @post = Post.new
    @image = @post.photos.build
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
    params.require(:post).permit(:post_title, :posted_text, :scene_id, photos_attributes: [:id]).merge(user_id: current_user.id)
  end

  def set_scenes
    @scenes = Scene.all
  end
end
