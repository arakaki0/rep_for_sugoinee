class UserController < ApplicationController
  before_action :authenticate_user, {only: [:edit,:update]}
  before_action :forbid_login_user, {only: [:login_form,:create,:login,:signup]}
  before_action :ensure_correct_user, {only: [:edit,:update]}

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/post/index")
    end
  end


  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end


  def login_form

  end

  def login
    @user = User.find_by(email: params[ :email])

     if @user && @user.authenticate(params[:password])
       session[:user_id]= @user.id
       flash[:notice] = "ログインしました"
       redirect_to("/post/index")
     else
       @error = "メールアドレスまたはパスワードが間違っています"
       @email = params[ :email]
      @password = params[ :password]
       render("user/login_form")
     end

  end

  def index
    @users = User.all
  end

 def show
   @user = User.find_by(id: params[:id])
 end

 def signup
   @user = User.new
 end

 def create
   @user = User.new(
       name: params[:name],
       email: params[:email],
       password: params[:password],
       image_name: "jisin_app_user.png"
       )
   if @user.save
     session[:user_id] = @user.id
     flash[:notice] = "新規登録が完了しました"
     redirect_to("/post/index")
   else
     render("user/signup")
   end
 end

 def edit
   @user = User.find_by(id: params[:id])
 end

 def update
   @user = User.find_by(id: params[:id])
   @user.name =  params[:name]
   @user.email = params[:email]
   @user.password = params[:password]

   if params[:image]
     @user.image_name = "#{@user.id}.jpg"
     image = params[:image]
     File.binwrite("public/user_images/#{@user.image_name}",image.read)
   end

   if @user.save
     flash[:notice] = "プロフィールを変更しました"
     redirect_to("/post/index")
   else
     render("user/edit")
   end

 end

end
