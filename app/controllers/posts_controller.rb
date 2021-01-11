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
    @like = Like.new
    @user = User.find_by(id: @post.user_id) #投稿をしたユーザーのuser_idを代入
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

  private
    def post_params
      params.require(:post).permit(:title, :content, :price, :img).merge(user_id: current_user.id)
    end
end
