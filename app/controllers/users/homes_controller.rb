class Users::HomesController < ApplicationController
  def top
    @posts_new = Post.all.order('created_at desc').limit(6)
  end

  def help
  end
end
