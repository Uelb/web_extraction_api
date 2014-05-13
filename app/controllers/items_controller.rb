class ItemsController < ApplicationController

  def index
    @website = Website.where(id: params[:website_id]).first
    @label = Label.includes({items: :parent}, :extraction).where(extractions: {website_id: params[:website_id]}, value: params[:label_id]).first
    redirect_to websites_path and return unless @label
    @items = @label.items
    respond_to do |format|
      format.json {render json: @items}
      format.xml {render xml: @items}
      format.csv {render text: @items.to_csv}
      format.xls {send_data @items.to_csv(col_sep: "\t")}
      format.html {authenticate_user! ; render layout: 'dashboard'}
      format.txt { render text: @items.map{|item| item.value + " | " + item.link}.join("\n")}
    end
  end

  def container_index
    @website = Website.where(id: params[:website_id]).first
    @label = Label.includes({items: {children: :label}}, :extraction).where(extractions: {website_id: params[:website_id]}, value: params[:label_id]).first
    redirect_to websites_path and return unless @label && @label.container
    
    @result = []

    # Le nom des différents labels disponibles, le premier nom est value
    labels = ["value"]
    labels += @label.items.map(&:children).flatten.map(&:label).uniq.sort_by(&:id).map &:value
    @label.items.map do |item|
      children = [item]
      children += item.children.sort_by do |child|
        child.label.id
      end
      hash = {}
      labels.each_with_index do |label, index|
        hash[label] = children[index].value if children[index]
      end
      @result << hash
    end
    respond_to do |format|
      format.json {render json: @result}
      format.xml {render xml: @result.to_xml}
      format.html {authenticate_user! ; render layout: 'dashboard'}
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
