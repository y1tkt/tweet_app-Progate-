class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[index show edit update]
  before_action :forbid_login_user, only: %i[new create login_form login]
  before_action :ensure_correct_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    case rand(1..8)
    when 1
      image_name = "default_user_BLU.png"
    when 2
      image_name = "default_user_CYN.png"
    when 3
      image_name = "default_user_GRN.png"
    when 4
      image_name = "default_user_GRY.png"
    when 5
      image_name = "default_user_PNK.png"
    when 6
      image_name = "default_user_PPL.png"
    when 7
      image_name = "default_user_RED.png"
    when 8
      image_name = "default_user_YEL.png"
    end
    @user = User.new(user_params)
    @user.image_name = image_name
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.account_id = params[:account_id]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(account_id: params[:account_id])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/posts/index"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @account_id = params[:account_id]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/login"
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if  @current_user.id != params[:id].to_i
      flash[:notice]  = "権限がありません"
      redirect_to "/posts/index"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :account_id, :email, :password, :password_confirmation)
  end
end
