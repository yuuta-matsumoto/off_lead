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
                       price: post_params[:price],
                         img: post_params[:img])
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
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    if post.update(user_id: current_user.id,
                      title: post_params[:title],
                    content: post_params[:content], 
                      price: post_params[:price],
                        img: post_params[:img])
      redirect_to posts_path
    else
      render action: :edit
    end
  end

  def destroy!
    @post = Post.find(params[:id])
    @post.destroy!
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :price, :img)
    end
end
