class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  def index
    @restaurants = Restaurant.order(:id).page(params[:page]).per(9)
  end
end
