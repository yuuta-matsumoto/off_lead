class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(params_review)
    @review.user_id = current_user.user_id
    if @review.save
      flash[:success] = "口コミを投稿しました"
      redirect_to post_path
    else
      render action: :new
    end
  end
  private
    def review_params
      params.require(:review).permit(:title, :content).merge(user_id: current_user.id)
    end
end
