class ItemsController < ApplicationController

  def index
    @website = Website.where(id: params[:website_id]).first
    @label = Label.includes(:items, :extraction).where(extractions: {website_id: params[:website_id]}, value: params[:label_id]).first
    redirect_to websites_path and return unless @label
    @items = @label.items
    respond_to do |format|
      format.json {render json: @items}
      format.xml {render xml: @items}
      format.csv {render text: @items.to_csv}
      format.xls {send_data @items.to_csv(col_sep: "\t")}
      format.html {authenticate_user! ; render layout: 'dashboard'}
      format.txt { render text: @items.map(&:value).join("\n")}
    end
  end

  def create
    @items = params[:items]
    new_items = @items.map do |item|
      image = false
      if item[:image]
        image = true
      end
      centroid = item.delete :centroid
      centroid = Centroid.create_from_array centroid
      item.merge({label_id: params[:label_id], centroid_id: centroid.id})
    end
    Item.create new_items
    render nothing: true
  end
end
