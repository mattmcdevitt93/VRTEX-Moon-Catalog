class ApplicationController < ActionController::Base
# Prevent CSRF attacks by raising an exception.
# For APIs, you may want to use :null_session instead.
protect_from_forgery with: :exception
	def admin_check
		if current_user.admin == false
			redirect_to :root, notice: 'Unauthroized Zone'
		end
	end
end
