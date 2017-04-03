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
    u_params = user_params

    training_images = []
    train_param = u_params.delete(:training_images).split(",")
    train_param.each_with_index do |img, i|
      if i % 2 != 0
        training_images << img
      end
    end

    if training_images.size > 0
      vision_params = {'images' => training_images, 'identity' => u_params[:vision_identity]}
      resp = Net::HTTP.post_form(URI.parse('http://localhost:3001/train'), vision_params)
      if resp.body != "success"
        flash[:danger] = "Could not train model. Try again"
        render 'new'
      end
    end

    @user = User.new(u_params)
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
    raise NotImplementedError
  end

  def update
    raise NotImplementedError
  end

  def destroy
    raise NotImplementedError
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :master_image, :vision_identity, :training_images)
  end

  def check_login
    unless logged_in?
      flash[:danger] = "Please log in first"
      redirect_to login_path
    end
  end
end
