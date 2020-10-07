class UsersController < ApplicationController
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
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: image_name
    )
    if @user.save
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
end
