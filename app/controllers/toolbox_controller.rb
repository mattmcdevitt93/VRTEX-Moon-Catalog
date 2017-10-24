class ToolboxController < ApplicationController
	before_filter :authenticate_user!, only: [:dashboard, :user_index, :catalog]
	before_action :admin_check, only: [:user_index, :dashboard]

	def landing
		
	end
	def dashboard

	end
	def user_index
		@user = User.paginate(:page => params[:page], :per_page => 50).order(id: :desc)
	end
	def catalog
		
	end
end