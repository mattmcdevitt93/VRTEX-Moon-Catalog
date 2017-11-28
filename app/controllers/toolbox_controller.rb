class ToolboxController < ApplicationController
	before_filter :authenticate_user!, only: [:dashboard, :user_index, :catalog, :search]
	before_action :admin_check, only: [:user_index, :dashboard]

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

		if params[:universe_update] == 'true' and current_user.admin == true
			Toolbox.universe_update

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
		# if params[:search] != nil && params[:region] == nil
			Rails.logger.info 'Search Check: ' +  params[:search].to_s
			# Wildcard Search
			# @results = Catalog.where("system_esi LIKE ?", "%#{params[:search]}%").where.not('status' => nil)

			@results = Catalog.paginate(:page => params[:page], :per_page => 75).where("system_esi LIKE ?", "#{params[:search]}").where.not('status' => nil || 3).order(moon_esi: :desc)
			@entry_results = @results.map(&:entry_id).uniq
			@mapped_results = @results.map(&:moon_id).uniq
		# else
		# 	Rails.logger.info 'Region Check'
		# 	# @region_list = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/regions/?datasource=singularity', nil)
		# 	@list = []
		# 	# @region_list.each do |i|
		# 	# 	item = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/regions/id/?datasource=singularity&language=en-us', i.to_s)
		# 	# 	@list.push(item)
		# 	# end
		end

	end
	def regions
		@test = 'Local Regions'
	end
	def systems

		@systems = Universe.where('region_id' => params[:region])

		# @region_list = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/regions/id/?datasource=singularity&language=en-us', params[:region])
		# Rails.logger.info @region_list.to_s
		# @region_list["constellations"].each do |i|


		# 	item = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/constellations/id/?datasource=singularity&language=en-us', i.to_s)
		# 	Rails.logger.info item

		# 	# @system_list.push(item)
		# end
	end


end