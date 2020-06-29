class Users::ScenesController < ApplicationController
  def show
  end

  def index
    @top_users = User.all.order('follower ')
  end
end
