class HomeController < ApplicationController
  def index
    @current_user = current_user
    @links = Link.find_by(user_id: @current_user.id) if @current_user
  end
end
