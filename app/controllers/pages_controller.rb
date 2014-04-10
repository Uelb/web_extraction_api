class PagesController < ApplicationController

  before_filter :authenticate_user!, only: :documentation

  def home
    
  end

  def about

  end

  def contact
    @feedback = Feedback.new
  end

  def documentation
    render layout: 'dashboard'
  end
end
