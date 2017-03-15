require 'digest'

class HomeController < ApplicationController
  def index
  end

  def digest
    str = digestion_params
    sha = Digest::MD5.hexdigest(str)
    render plain: sha
  end

  private

  def digestion_params
    params.require(:string)
  end
end
