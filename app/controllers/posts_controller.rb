class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  add_breadcrumb "ホーム" , :root_path
  add_breadcrumb 'ユーザー一覧', :users_path

  def new
    @post = Post.new
    @user = User.find_by(id: @post.user_id)
    add_breadcrumb "新規投稿", :new_post_path
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to controller: :users, action: :show, id: current_user.id
    else
      render action: :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @reviews = @post.reviews
    @like = Like.new
    @user = User.find_by(id: @post.user_id) #投稿をしたユーザーのuser_idを代入
    add_breadcrumb "#{@user.name}", "/users/#{@user.id}"
    add_breadcrumb "#{@post.title}", :post_path
  end

  def edit
    @post = Post.find(params[:id])
    @user = User.find_by(id: @post.user_id)
    add_breadcrumb "#{@user.name}", :users_path
    add_breadcrumb "#{@post.title}", :post_path
    add_breadcrumb '編集', :edit_post_path
  end

  def update
    post = Post.find(params[:id])
    if post.update(post_params)
      redirect_to controller: :users, action: :show, id: current_user.id
    else
      render action: :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
     if @post.destroy!
      redirect_to controller: :users, action: :show, id: current_user.id
     else
      redirect_to action: :show, alert: "削除できませんでした"
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :content, :price, :img).merge(user_id: current_user.id)
    end
end
