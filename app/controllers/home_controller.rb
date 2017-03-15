class HomeController < ApplicationController
  def index
    @books = %w(hormoz djordje colin)
    "hello"
  end
end
