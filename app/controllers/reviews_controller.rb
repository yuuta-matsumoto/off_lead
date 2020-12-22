class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.new(review_params)
    @review.save
    redirect_to request.referer
  end
  private
    def review_params
      params.require(:review).permit(:post_id, :title, :content, :rate).merge(user_id: current_user.id)
    end
end
