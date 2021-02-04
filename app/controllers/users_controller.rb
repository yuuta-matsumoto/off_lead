class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :likes, :following, :follower]
  before_action :set_user, only: [:show, :following, :follower, :likes]
  before_action :create_message_room, only: [:show, :following, :follower, :likes] 

  add_breadcrumb "ホーム" , :root_path
  add_breadcrumb 'ユーザー一覧', :users_path

  def index
    @users = User.all.order("created_at ASC").page(params[:page]).per(10)
  end

  def show
    @posts = @user.posts
    add_breadcrumb "#{@user.name}", :user_path
  end
  #いいね機能のメソッド
  def likes
    @user = User.find_by(id: params[:id])
    add_breadcrumb "#{@user.name}", :user_path
    add_breadcrumb 'いいね', "/users/#{@user.id}/likes"
  end

  #フォロー機能のメソッド
  def following
    add_breadcrumb "#{@user.name}", :user_path
    add_breadcrumb 'フォロー中', :following_user_path
  end

  def follower
    add_breadcrumb "#{@user.name}", :user_path
    add_breadcrumb 'フォロワー', :follower_user_path
  end

  private

    def set_user
      @user  = User.find(params[:id])
    end

    def create_message_room #メッセージルームに移動or新たに作成
      @currentUserEntry = Entry.where(user_id: current_user.id) #ボタンを押したユーザーを探す
      @userEntry = Entry.where(user_id: @user.id) #ボタンを押されたユーザーを探す。
      unless @user.id == current_user.id #現在ログインしているユーザーではない（自分に対してはroomを作成できない）
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id  #ルームがすでに作成されている場合
              @isRoom = true #false(roomが未作成)の時にroomを作成する条件を記述するため
              @roomId = cu.room_id
            end
          end
        end
        
        unless @isRoom 
          @room = Room.new
          @entry = Entry.new
        end
      end  
    end

end
