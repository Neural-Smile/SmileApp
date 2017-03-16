class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:login, :manual_login]

  def login
  end

  def manual_login
  end

  def create
    user = if(session_params[:password])
      login_with_password
    elsif(session_params[:user_image])
      login_with_vision
    else
      false
    end

    if user
      log_in(user)
      redirect_to user
    else
      render json: {
        success: false,
        error: "We couldn't recognize you, mind trying again?"
      }
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def login_with_password
    user = User.find_by(email: session_params[:email].downcase)
    user if user && user.authenticate(session_params[:password])
  end

  def login_with_vision
    b64image = User.image_from_params(session_params[:user_image])
    User.authenticate_with_vision(b64image)
  end

  def session_params
    params.require(:session).permit(:email, :password, :user_image)
  end

  def redirect_if_logged_in
    if logged_in?
      redirect_to current_user
    end
  end
end
