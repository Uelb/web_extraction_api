class CentroidsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @website = Website.where(website_params).first
    @website||= Website.new(website_params)
    @extraction = Extraction.new extraction_params
    @extraction.website = @website
    @extraction.user = current_user
    @website.save
    @extraction.save
    params[:labels].each do |value, info|
      @label = Label.new
      @label.extraction = @extraction
      @label.value = value
      @label.container = info[:container]
      centroids = info[:centroids]
      centroids.each do |index, centroid|
        @centroid = Centroid.new
        @centroid.label = @label
        @centroid.level = centroid[:depth]
        [:color=, :background_color=, :width=, :height=, :text_decoration=, :font_style=, 
          :left_alignment=, :top_alignment=, :z_index=, :padding_l_r=, :padding_t_b=, :border_horizontal_width=, :border_vertical_width=].each_with_index do |attribute, index|
          @centroid.send attribute, centroid[:centroid][index]
        end
        @centroid.save
      end
    end
    Thread.new do
      Website.update_items
      Item.generate_links
    end
    render json: @website.to_json(include: :extractions)
  end

  private
  def website_params
    params.permit :url
  end
  def extraction_params
    params.require(:weights).permit(:color, :background_color, :z_index, :font_style, :width, :height, :text_decoration, :top_alignment, :left_alignment, :padding_l_r, :padding_t_b, :border_horizontal_width, :border_vertical_width)
  end
end