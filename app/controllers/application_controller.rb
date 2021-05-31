class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  def configure_permitted_parameters
    # ログイン時に名前とパスワードが必要な為、sign_upだけでなく、loginの記述が必要かも？
    devise_parameter_sanitizer.permit(:sign_up, keys:[:name])
    # できればまとめたい！
    devise_parameter_sanitizer.permit(:sign_in, keys:[:name])
  end
end
