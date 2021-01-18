class ReviewsController < ApplicationController
  add_breadcrumb "ホーム" , :root_path
  add_breadcrumb 'ユーザー一覧', :users_path

  def new
    @post = Post.find(params[:id])
    @review = Review.new
    @user = User.find_by(id: @post.user_id) #投稿をしたユーザーのuser_idを代入
    add_breadcrumb "#{@user.name}", :users_path
    add_breadcrumb "#{@post.title}", :post_path
    add_breadcrumb '口コミを投稿', "/posts/#{@post.id}/reviews/new"
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
