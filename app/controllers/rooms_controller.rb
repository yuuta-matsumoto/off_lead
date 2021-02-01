class RoomsController < ApplicationController
  before_action :authenticate_user!
  add_breadcrumb "ホーム" , :root_path
  add_breadcrumb 'ユーザー一覧', :users_path

  def create
    @room = Room.create(user_id: current_user.id)#現在ログインしているユーザーのentry
    @entry1 = Entry.create(room_id: @room.id, 
                            user_id: current_user.id)#fields_forから送られてきたparams(:user_id, room_id)を許可する
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end

  def show
    @room = Room.find(params[:id]) #1つのメッセージルームを表示する
    #ログインしているユーザーとそれに紐づくroom.idを探す
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages #@roomと紐づいたメッセージを表示する
      @message = Message.new #messageのインスタンスを作成するため
      @entries = @room.entries #ユーザーの名前などの情報を表示するため
      #パンクズで相手ユーザー名を表示する
      @entries.each do |e|
        unless e.user.name == current_user.name
          add_breadcrumb "#{e.user.name}", "/users/#{e.user.id}"
        end
      end
    else
      redirect_back(fallback_location: root_path) #前のページに戻す
    end
      add_breadcrumb "メッセージ", :room_path
  end

end
