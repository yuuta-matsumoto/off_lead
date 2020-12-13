class ReviewsController < ApplicationController

  def create
  @review = current_user.reviews.new(review_params)
    if @review.save
      flash[:success] = "口コミを投稿しました"
      redirect_to post_path
    else
      render action: :new
    end
  end
  private
    def review_params
      params.require(:review).permit(:post_id, :user_id, :title, :content)
    end
end
