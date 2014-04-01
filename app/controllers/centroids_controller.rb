class CentroidsController < ApplicationController

  def show
    path = params[:path]
    @json = File.read("public/jsons/#{path}.json")
    render json: @json
  end

  def create
    @website = Website.where(website_params).first_or_create
    params[:centroids].each do |label, node|
      centroid = node[:centroid]
      @centroid = Centroid.new
      @centroid.label = label
      @centroid.level = node[:depth]
      [:color=, :background_color=, :width=, :height=, :text_decoration=, :font_style=, 
        :left_alignment=, :top_alignment=, :z_index=].each_with_index do |attribute, index|
          @centroid.send attribute, centroid[index]
      end
      @centroid.website = @website
      @centroid.save
    end
    render json: @website.to_json(include: :centroids)
  end

  def get_from_label

  end

  private
  def website_params
    params.permit :url
  end

  def centroid_params
  
  end

end