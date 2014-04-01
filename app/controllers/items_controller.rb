class ItemsController < ApplicationController

  def index
    @centroid = Centroid.where(website_id: params[:id], label: params[:label].downcase)
    @items = @centroid.items
    render json: @items
  end

end
