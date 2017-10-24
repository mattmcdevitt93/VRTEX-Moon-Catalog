class ToolboxController < ApplicationController
	before_filter :authenticate_user!, only: [:dashboard, :user_index, :catalog]
	before_action :admin_check, only: [:user_index, :dashboard]

	def landing
		
	end
	def dashboard

		if params[:start_task] == 'true' and current_user.admin == true
			Moon.Moon_Parse
			redirect_to dashboard_path
		end

	end
	def user_index
		@user = User.paginate(:page => params[:page], :per_page => 50).order(id: :desc)
	end
	def catalog
		
	end
end