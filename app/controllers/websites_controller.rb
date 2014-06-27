class WebsitesController < ApplicationController

  PROPERTIES_ARRAY = [:color, :background_color, :width, :height, :text_decoration, :font_style, :left_alignment, :top_alignment, :z_index, :padding_l_r, :padding_t_b, :border_horizontal_width, :border_vertical_width]

  before_filter :authenticate_user!, only: [:new, :extraction]

  def show
    @website = Website.where(id: params[:id])
    respond_to do |format|
      format.json {render json: @website.to_json(include: :labels)}
      format.xml {render xml: @website.to_xml(include: :labels)}
      format.csv {render text: @website.to_csv}
      format.xls {send_data @website.to_csv(col_sep: "\t")}
      format.html {authenticate_user!; render layout: 'dashboard'}
    end
  end

  def get_from_label
    @centroid = Centroid.where(params.slice(:website_id, :label)).first
    @items = @centroid.items
    render json: @items
  end

  def index 
    @websites = Website.includes(:labels => :centroids)
    respond_to do |format|
      format.json {render json: @websites.to_json(include: {labels: {include: :centroids}} ) }
      format.xml {render xml: @websites.to_xml(include: {labels: {include: :centroids}} ) }
      format.csv {render text: @websites.to_csv}
      format.xls {send_data @websites.to_csv(col_sep: "\t")}
      format.html{authenticate_user!; render layout: 'dashboard'}
    end
  end

  def new
    render layout: 'dashboard'
  end

  def extraction
    @url = params[:url]
    @url.strip!
    if !@url.start_with? "http"
      @url = "http://#{@url}"
    end
    @weights = params[:weights]
    temp = []
    PROPERTIES_ARRAY.each do |property|
      temp << @weights[property]
    end
    @weights = temp
    @weights.map! do |weight|
      if weight.blank?
        1
      else
        weight.to_f
      end
    end
    @html = Website.get_html_from_node_script(@url, @weights)
    p @html
    temp = {}
    PROPERTIES_ARRAY.each_with_index do |property, index|
      temp[property] = @weights[index]
    end
    @weights = temp
    @head, @body = Website.parse(@html).map(&:to_html)
    render layout: false
  end

  def destroy
    Website.find(params[:id]).destroy
    redirect_to websites_path
  end
end
