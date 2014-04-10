class CentroidsController < ApplicationController

  def create
    @website = Website.where(website_params).first_or_create
    params[:labels].each do |value, centroids|
      @label = Label.new
      @label.website = @website
      @label.value = value
      centroids.each do |index, centroid|
        @centroid = Centroid.new
        @centroid.label = @label
        @centroid.level = centroid[:depth]
        [:color=, :background_color=, :width=, :height=, :text_decoration=, :font_style=, 
          :left_alignment=, :top_alignment=, :z_index=].each_with_index do |attribute, index|
          @centroid.send attribute, centroid[:centroid][index]
        end
        @centroid.save
      end
    end
    render json: @website.to_json(include: :labels)
  end

  private
  def website_params
    params.permit :url
  end
end