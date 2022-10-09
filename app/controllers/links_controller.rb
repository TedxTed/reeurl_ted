class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  require 'zlib'

  def index
    @links = Link.all
  end

  def new
    @ink = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      redirect_to '/', notice: 'Link was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def redirect_to_orginurl
    slug = params[:slug]
    orginurl = Link.find_by(slug:)&.orginurl
    if orginurl
      redirect_to orginurl, allow_other_host: true
    else
      render_404
    end
  end

  private

  def link_params
    params.require(:link).permit(:orginurl, :user_id)
  end
end
