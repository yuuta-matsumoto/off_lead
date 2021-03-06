class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_current_location, unless: :devise_controller?

  def after_sign_in_path_for(resouce)
    root_path
  end

    private

    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

    def store_current_location
      store_location_for(:user, request.url)
    end

    protected
    def configure_permitted_parameters
      added_attrs = [:name, :email, :password, :img]
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :content])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :content, :password, :img])
    end
end
