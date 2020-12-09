class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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



  private
    def post_params
      params.require(:post).permit(:title, :content, :price)
    end
end
