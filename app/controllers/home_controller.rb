require 'digest'
require 'base64'

class HomeController < ApplicationController
  def index
    if logged_in?
      redirect_to current_user
    else
      redirect_to login_path
    end
  end

  def digest
    if image_params[:name].nil?
      head :bad_request
    end

    image = User.image_from_params(image_params[:data])

    if image.nil?
      head :bad_request
    end

    png = User.decode_image(image)

    file = "#{Rails.root}/public/pics/pic#{image_params[:name]}.png"

    File.open(file, 'wb') { |f| f.write(png) }

    if File.exist?(file)
      head :ok
    else
      head :internal_server_error
    end
  end

  private

  def image_params
    params.require(:image).permit(:data, :name)
  end
end
