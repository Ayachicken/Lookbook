class Admins::ScenesController < ApplicationController
  def index
    @scene = Scene.new
    @scenes = Scene.all
  end

  def create
    @scene = Scene.new(scene_params)
    if @scene.save
      redirect_to admins_scenes_path
    else
      render :new
    end
  end

  def update
    @scene = Scene.find(params[:id])
    if @scene.validity == 0
      @scene.validity = 1
      @scene.save!
      redirect_back(fallback_location: admins_top_path)
    else
      @scene.validity = 0
      @scene.save!
      redirect_back(fallback_location: admins_top_path)
    end
  end

  def destroy
  end

  private
  def scene_params
    params.require(:scene).permit(:scene_name)
  end
end
