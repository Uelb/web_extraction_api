class LabelsController < ApplicationController

  def index
    @website = Website.includes(:labels).where(id: params[:website_id]).first
    @labels = @website.labels
    respond_to do |format|
      format.json {render json: @labels}
      format.xml {render xml: @labels}
      format.csv {render text: @labels.to_csv}
      format.xls {send_data @labels.to_csv(col_sep: "\t")}
      format.html{render layout: 'dashboard'}
    end    
  end

  def show
    @label = Label.where(website_id: params[:website_id], value: params[:id]).first
    render json: @label
  end

  def destroy
    Label.where(website_id: params[:website_id], value: params[:id]).first.destroy
    redirect_to websites_path
  end
end
