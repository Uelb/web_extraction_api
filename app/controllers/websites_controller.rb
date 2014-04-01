class WebsitesController < ApplicationController

  def get_from_label
    @centroid = Centroid.where(params.slice(:website_id, :label)).first
    @items = @centroid.items
    render json: @items
  end

end
