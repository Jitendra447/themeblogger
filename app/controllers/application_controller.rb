class ApplicationController < ActionController::Base
	before_filter :configure_permitted_parameters, if: :devise_controller?  # for permitting parameters at time of sign_up.
 #	before_action :authenticate_author!, :except => [:show, :index, :author_profile]
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # layout :layout_by_resource


def after_sign_in_path_for(resource)
	root_path
end

def after_sign_up_path_for(resource)
	articles_path
end

def after_sign_out_path_for(resource)
	root_path
end
protected
 def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:author_pic, :username, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:author_pic, :username, :email, :password, :password_confirmation, :current_password)}
  end

# def layout_by_resource
#   if devise_controller? && resource_name == :author && action_name == "new"
#     "sessions"
#   else
#     "application"
#   end
# end

end
