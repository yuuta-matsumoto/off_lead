class ReviewsController < ApplicationController

  def new
    @post = Post.find(params[:id])
    @review = Review.new
    @user = User.find_by(id: @post.user_id) #投稿をしたユーザーのuser_idを代入
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to controller: :posts, action: :show, id: @review.post.id
    else
      render action: :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:post_id, :title, :content, :rate)
                             .merge(user_id: current_user.id)
    end
end
