class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :target_category, :only => [:update, :destroy]

  # 以下before-action中之內容是配合(MEW#1), 並搭配render算繪index.html樣板
  # before_action :target_category, :only => [:edit, :update]

  def index
    # 算繪index.html.erb時，@categories及@category都是要準備好的
    @categories = Category.all
    
    if params[:id]
      target_category
    else
      @category = Category.new
    end
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

  def update
    if @category.update_attributes(category_params)
      flash[:notice] = "category updated successfully"
      redirect_to admin_categories_path
    else
      flash[:alert] = "Fail to update a category"
      @categories = Category.all
      render :action => :index
    end
  end

  def destroy
    @category.destroy
    redirect_to admin_categories_path
  end

  # 以下edit-action中之內容是配合(MEW#1), 並搭配render算繪index.html樣板
  # def edit
  #   @categories = Category.all
  #   render :action => :index
  # end

  # 以下update-action中之內容是配合(MEW#1), 並搭配render算繪index.html樣板
  # def update
  #   if @category.update_attributes(category_params)
  #     flash[:notice] = "category updated successfully"
  #     redirect_to admin_categories_path
  #   else
  #     flash[:alert] = "Fail to update a category"
  #     render :action => :edit
  #   end
  # end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  # 以下target_category用於before_action之中，依(MEW#1), 並搭配render算繪index.html樣板
  def target_category
    @category = Category.find(params[:id])
  end
end
