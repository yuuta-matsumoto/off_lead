# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  #ゲストログインのメソッド
  def new_guest
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  

end
