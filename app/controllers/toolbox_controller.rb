class ToolboxController < ApplicationController
	before_filter :authenticate_user!, only: [:dashboard, :user_index, :catalog]
	before_action :admin_check, only: [:user_index, :dashboard, :search]

	def landing
		
	end
	def dashboard

		if params[:moon_parse] == 'true' and current_user.admin == true
			Moon.Moon_Parse
			redirect_to dashboard_path
		end

		if params[:catalog_parse] == 'true' and current_user.admin == true
			Catalog.catalog_parse
			redirect_to dashboard_path
		end

	end
	def user_index
		@user = User.paginate(:page => params[:page], :per_page => 50).order(id: :desc)
	end
	def catalog
		
	end
	def search
		if params[:search] != nil
			Rails.logger.info 'Search Check: ' +  params[:search].to_s
			# Wildcard Search
			# @results = Catalog.where("system_esi LIKE ?", "%#{params[:search]}%").where.not('status' => nil)

			@results = Catalog.paginate(:page => params[:page], :per_page => 50).where("system_esi LIKE ?", "#{params[:search]}").where.not('status' => nil || 3).order(moon_esi: :desc)
			@entry_results = @results.map(&:entry_id).uniq
			@mapped_results = @results.map(&:moon_id).uniq
		else
			Rails.logger.info 'Manual Check'
		end

	end

end