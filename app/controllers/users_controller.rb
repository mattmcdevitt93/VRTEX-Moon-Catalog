class UsersController < ApplicationController
	before_action :admin_check, only: [:index]

	def index
	end
	def update
		Rails.logger.info "Update User: " + params.to_s

		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to :back
		else
			render 'edit'
		end
	end

	protected

	def update_resource(resource, params)
		resource.update_without_password(params)
	end

	private

	def user_params
      params.require(:user).permit(:id, :admin, :blacklist)
    end
end