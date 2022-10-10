class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:redirect_to_orginurl]
  before_action :find_link, only: %i[edit update destroy]
  require 'zlib'

  def index
    @domain = ENV.fetch('DOMAIN_SHORT_URL', nil)
    @current_user = current_user
    @links = @current_user.links if @current_user
  end

  def new
    @link = current_user.links.new
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to links_url, notice: 'Link was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @link.update(link_params)
      redirect_to links_url, notice: 'Link was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link = Link.find_by(id: params[:id])
    if @link
      @link.destroy
      redirect_to links_url
    else
      render_404
    end
  end

  def redirect_to_orginurl
    slug = params[:slug]
    orginurl = Link.find_by(slug: slug)&.orginurl
    if orginurl
      redirect_to orginurl, allow_other_host: true
    else
      render_404
    end
  end

  private

  def find_link
    @link = Link.find_by(id: params[:id])
  end

  def link_params
    params.require(:link).permit(:orginurl, :user_id)
  end
end
