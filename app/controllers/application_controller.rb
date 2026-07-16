class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [ :name, :tel_number, :email, :password ]
    devise_parameter_sanitizer.permit :account_update, keys: [ :name, :tel_number, :email, :password ]
  end

  def after_sign_in_path_for(resource)
    resource.admin? ? admin_root_path : homes_path
  end
end
