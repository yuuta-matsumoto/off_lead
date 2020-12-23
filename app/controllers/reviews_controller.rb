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


    #口コミ通知のメソッド
  def create_notification_review!(current_user, review_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Review.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_review!(current_user, review_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_review!(current_user, review_id, user_id) if temp_ids.blank?
  end

  def save_notification_review!(current_user, review_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      review_id: review_id,
      visited_id: visited_id,
      action: 'review'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  

    private
        def review_params
          params.require(:review).permit(:post_id, :title, :content).merge(user_id: current_user.id)
        end
end
