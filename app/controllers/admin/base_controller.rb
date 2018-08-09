class Admin::BaseController < ApplicationController
  before_action :authenticate_admin

  private
  def authenticate_admin
    if !(current_user.admin?)
      flash[:alert] = "Authentication Level : Normal"
      redirect_to root_path
    end
  end
end