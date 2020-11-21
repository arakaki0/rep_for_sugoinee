class LikeController < ApplicationController

 def destroy
   @like = Like.find_by(user_id: @current_user.id,post_id: params[:post_id])
   @like.destroy
   redirect_to("/post/#{params[:post_id]}")
 end

 def create
  @like = Like.new(user_id: @current_user.id,post_id: params[:post_id])
  @like.save
  @user=User.find_by(id: @current_user.id)
  @user.point += 1
  @user.save
  redirect_to("/post/#{params[:post_id]}")
 end

end
