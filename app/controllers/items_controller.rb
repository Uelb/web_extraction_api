class ItemsController < ApplicationController

  def index
    @website = Website.where(id: params[:website_id]).first
    @label = Label.includes(:items).where(website_id: params[:website_id], value: params[:label_id]).first
    @items = @label.items
    respond_to do |format|
      format.json {render json: @items}
      format.xml {render xml: @items}
      format.csv {render text: @items.to_csv}
      format.xls {send_data @items.to_csv(col_sep: "\t")}
      format.html {render layout: 'dashboard'}
      format.txt { render text: @items.map(&:value).join("\n")}
    end
  end

  def create
    @items = params[:items]
    Item.create @items.map{|item| {label_id: params[:label_id], value: item}}
    render nothing: true
  end
end
