class CommentsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])

    # "build"及"new"差不多 ; 但貌似"build"會自動幫忙設置@comment的外鍵restaurant_id
    # PS: 現行版本，@restaurant.comments.build 和 @restaurant.comments.new 沒有差別
    # 此處 (restaurant, comments)=(一 對 多)-->故只能接 ".comments" or ".comments=" 這兩種方法
    # 新版Rails規定，要從表單中拿出資料(ps: id類除外), 一定得用strong parameter的寫法, 即下方private方法"comment_params"
    @comment = @restaurant.comments.build(comment_params)

    # user_id一樣不可少! (PS : 否則無法存入database, 而且會出現HTTP "302" error )
    @comment.user = current_user

    @comment.save
    redirect_to restaurant_path(@restaurant)
  end

  # 新版Rails規定，要從表單中拿出資料(ps: id類除外), 一定得用strong parameter的寫法, 即下方private方法"comment_params"
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
