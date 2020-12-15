class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @currentUserEntry = Entry.where(user_id: current_user.id) #ボタンを押したユーザーを探す
    @userEntry = Entry.where(user_id: @user.id) #ボタンを押されたユーザーを探す。
    unless @user.id == current_user.id #現在ログインしているユーザーではない（自分に対してはroomを作成できない）
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then #ルームがすでに作成されている場合
            @isRoom = true #false(roomが未作成)の時にroomを作成する条件を記述するため
            @roomId = cu.room_id
          end
        end
      end

      if @isRoom #true（すでにroomがある）なら何も起きない
      else #false(room)が未作成なら新しいインスタンスを作成するためのnewを記述
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

end
