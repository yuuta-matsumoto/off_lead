class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    binding.pry
    if @review.save
      flash[:success] = "口コミを投稿しました"
      redirect_to post_path
    else
      render action: :new
    end
  end
  private
    def review_params
      params.require(:review).permit(:title, :content)
    end
end
