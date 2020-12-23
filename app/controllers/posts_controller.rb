class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all
    @user = User.find_by(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to posts_path
    else
      render action: :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @reviews = @post.reviews
    @review = @post.reviews.new
    @like = Like.new 
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to posts_path
    else
      render action: :new
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to posts_path
  end
 
  #いいね通知のメソッド
  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
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
        def post_params
          params.require(:post).permit(:title, :content, :price, :img).merge(user_id: current_user.id)
        end
end
