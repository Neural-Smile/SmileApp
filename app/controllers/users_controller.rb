class UsersController < ApplicationController
  def index
    @users = User.all
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
end
