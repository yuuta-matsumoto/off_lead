class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_id: current_user.id,
                       title: post_params[:title],
                     content: post_params[:content], 
                       price: post_params[:price])
    if @post.save
      redirect_to posts_path
    else
      render action: :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(user_id: current_user.id,
                      title: post_params[:title],
                    content: post_params[:content], 
                      price: post_params[:price])
      redirect_to posts_path
    else
      render action: :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :price)
    end
end
