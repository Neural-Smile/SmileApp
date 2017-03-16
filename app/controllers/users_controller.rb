class UsersController < ApplicationController
  before_action :check_login, except: [:new, :create]

  def index
    redirect_to current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    image = User.image_from_params(user_params[:master_image])

    if image.nil?
      flash[:danger] = "Image was not received correctly"
      render 'new'
    end

    png = User.decode_image(image)

    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Sign up successful. Welcome to Smile"
      redirect_to @user
    else
      flash[:danger] = "Error signing up try again"
      render 'new'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :master_image)
  end

  def check_login
    unless logged_in?
      flash[:danger] = "Please log in first"
      redirect_to root_path
    end
  end
end
