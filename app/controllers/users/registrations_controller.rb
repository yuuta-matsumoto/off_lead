# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :check_guest, only: [:update, :destroy]

  add_breadcrumb "ホーム" , :root_path
  add_breadcrumb 'ユーザー一覧', :users_path
  add_breadcrumb 'プロフィール編集', :edit_user_registration_path
  #ゲストユーザーを削除できないようにする
  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to edit_user_registration_path, alert: 'ゲストユーザーの編集・削除はできません。'
    end
  end

  protected
    
    #プロフィール更新時にパスワードを求めない
    def update_resource(resource, params)
      resource.update_without_password(params)
    end

end
