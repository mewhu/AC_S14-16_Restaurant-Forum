class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  private
  def authenticate_admin
    if !(current_user.admin?)
      flash[:alert] = "Authentication Level : Normal"
      redirect_to root_path
    end
  end
end
