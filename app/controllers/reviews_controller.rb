class ReviewsController < ApplicationController

  def create
    @review = current_user.reviews.new(review_params)
    @post = @review.post
    if @review.save
      @post.create_notification_review!(current_user)
      redirect_to request.referer
    else
      render 'posts/show'
    end
  end

    private
        def review_params
          params.require(:review).permit(:post_id, :title, :content).merge(user_id: current_user.id)
        end
end
