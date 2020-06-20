class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      users_top_path
    else
      admins_top_path
    end
  end

  # ログアウト後のリダイレクト先
  def after_sigh_out_path_for(resource)
    if resource.is_a?(User)
      users_top_path
    else
      new_admin_session_path
    end
  end

end
