class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
    if @current_user
      posts_count = Post.where(user_id: @current_user.id)
      posts_count.each do |post_count|
      likes= Like.where(post_id: post_count)
      @like_count = likes.count
      end
    end
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインが必要です"
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to("/post/index")
    end
  end

end
