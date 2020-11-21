class PostController < ApplicationController

before_action :ensure_correct_user, {only: [:edit,:update,:destroy]}

def ensure_correct_user
  @post = Post.find_by(id: params[:id])

  if @post.user_id != @current_user.id
    flash[:notice] = "権限がありません"
    redirect_to("/post/index")
  end

end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to("/post/index")
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]

    if @post.save
     flash[:notice] = "投稿が更新されました！"
     redirect_to("/post/index")
    else
     render("post/edit")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def create
    @post = Post.new(content: params[:content],user_id: @current_user.id)
    @user=@post.user
    if @user.point >= 3
      @user.point -= 3
      @user.save
      @post.save
      flash[:notice] = "投稿が完了しました。"
      redirect_to("/post/index")
    elsif @user.point < 3
      flash[:notice]="投稿するにはあと#{3-@user.point}回他の人をスゴイね！してください"
      redirect_to("/post/index")
    else
      render("post/new")
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
  end

  def index
     @posts = Post.all.order(created_at: :desc)
  end
end
