require 'reloader/sse'

class UrlsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_url, only: [:destroy, :edit, :update]
  before_action :create_url?, only: :create

  def index
    @urls = current_user.urls
  end

  def new
    @url = Url.new
    current_user
  end

  def create
    @url = Url.new(url_params)
    if @url.valid?
      current_user.urls << @url
      redirect_to urls_path
    else
      render :new
    end
  end

  def update
    if @url.update_attributes(url_params)
      redirect_to urls_path, success: 'Url has been updated successfully.'
    else
      render :edit, error: 'Some error occured.'
    end
  end

  def destroy
    if @url.destroy
      redirect_to urls_path, success: 'Url has been removed successfully.'
    else
      flash[:error] = 'Unable to delete the url.'
    end

  end

  private
  def get_url
    @url = Url.where(id: params[:id]).first
    redirect_to urls_path if @url.blank?
  end

  def create_url?
    if current_user.full_url?
      flash[:error] = 'Max limit reached.'
      redirect_to new_url_path
    end
  end

  def url_params
    params.require(:url).permit(:address)
  end
end
