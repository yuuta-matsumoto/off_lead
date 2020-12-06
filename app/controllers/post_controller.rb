class PostController < ApplicationController
  def new
    
  end

  def index
    @post = Post.all
  end
end
