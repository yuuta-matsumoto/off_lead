# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_guest, only: [:update, :destroy]
  #ゲストユーザーを削除できないようにする
  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの編集・削除はできません。'
    end
  end

  protected
    
    #プロフィール更新時にパスワードを求めない
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

end
