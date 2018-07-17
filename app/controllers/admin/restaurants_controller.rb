class Admin::RestaurantsController < ApplicationController
  # 重申用法：先用"devise"產生了含認證功能的user model
  # 　　　　　再將devise提供出來的"一些認證功能之集合(ex: authenticate_user!),掛到欲加入認證功能的Controller上
  # 不甚合理：假設一個使用者的role="admin", 從127.0.0.1:3000 的登入頁面成功登入後只能留在餐廳前臺...
  before_action :authenticate_user!
  before_action :authenticate_admin


  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "Restaurant created successfully"
      redirect_to admin_restaurants_path
    else
      flash[:alert] = "Fail to create a restaurant"
      render :new
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hour, :description)
  end
end
