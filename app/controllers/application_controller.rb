class ApplicationController < ActionController::Base

  # ログイン済ユーザーのみにアクセスを許可
  before_action :authenticate_user!, except: [:top, :about]

  before_action :configure_permitted_parameters, if: :devise_controller?

#ログイン後のルート先はユーザー詳細画面show
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

#ログアウトのルート先はトップページtop
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

# 新規登録の際、nameの情報を送ってもいいように許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
