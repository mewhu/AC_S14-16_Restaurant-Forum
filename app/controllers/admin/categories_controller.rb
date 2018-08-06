class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    # 算繪index.html.erb時，@categories及@category都是要準備好的
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category created successfully"
      redirect_to admin_categories_path
    else
      flash[:alert] = "Could not create category"

      # 因為create不成功時要"直接去算繪(render)"index.html樣板，故此處需重新準備一份實例變數@categories
      @categories = Category.all
      render :action => :index
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end
