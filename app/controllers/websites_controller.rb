class WebsitesController < ApplicationController

  before_filter :authenticate_user!, only: :new

  def get_from_label
    @centroid = Centroid.where(params.slice(:website_id, :label)).first
    @items = @centroid.items
    render json: @items
  end

  def index 
    @websites = Website.includes(:labels => :centroids)
    respond_to do |format|
      format.json {render json: @websites.to_json(include: {labels: {include: :centroids}})}
      format.xml {render xml: @websites.to_xml(include: {labels: {include: :centroids}})}
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
    @weights = params[:weights]
    @html = Website.get_html_from_node_script(@url, @weights)
    @head, @body = Website.parse(@html).map(&:to_html)
    render layout: false
  end
end
