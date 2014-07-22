class FeedbacksController < ApplicationController

  before_filter :authenticate_user!
  def my_user
  	respond_to do |format|
  		format.json {render json: current_user}
  	end
  end
end
