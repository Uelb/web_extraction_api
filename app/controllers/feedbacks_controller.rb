class FeedbacksController < ApplicationController

  def create
    Feedback.create feedback_params
    redirect_to contact_path, notice: "Thank you for your feedback, we will answer you as soon as possible"
  end

  private
  def feedback_params
    params.require(:feedback).permit :name, :email, :content
  end

end
