class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  require 'zlib'

  def index 
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    p params 
    @link = Link.new(link_params)
    if @link.save
      p @link
      redirect_to link_url(@link), notice: "Link was successfully created." 
    else
      render :new, status: :unprocessable_entity 
    end
  end

  def redirect_to_orginurl
    slug = params[:slug]
    orginurl = Link.find_by(slug: slug).orginurl if slug.present?
    redirect_to orginurl , allow_other_host: true
  end

  private
  def link_params
    params.require(:link).permit(:orginurl,:user_id)
  end

end
