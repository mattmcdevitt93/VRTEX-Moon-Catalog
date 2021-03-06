class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception
def admin_check
	if current_user.admin == false
		redirect_to :root, notice: 'Unauthroized Zone'
	end
end

def approval_check
	if current_user.blank? == false
		if  current_user.approved_user == false
			if current_user.admin == false
				redirect_to :root, notice: 'Unauthroized Zone'
			end
		end
	end
end

def blacklist_check
	if current_user.blank? == false
		if current_user.blacklist == true
			if current_user.admin == false
				redirect_to :root, notice: 'Unauthroized Zone.'
			end
		end
	end
end

before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
	update_attrs = [:password, :password_confirmation, :current_password, :blacklist, :admin]
	devise_parameter_sanitizer.permit :account_update, keys: update_attrs
end

end
