class ToolboxController < ApplicationController
	before_filter :authenticate_user!, only: [:dashboard, :user_index, :catalog, :search, :user_catalog]
	before_action :admin_check, only: [:user_index, :dashboard, :user_dashboard, :flagged]

	def landing
		
	end
	def user_dashboard
		@user = User.paginate(:page => params[:page], :per_page => 50).order(id: :desc)
	end
	def info
		@catalogs = Catalog.where('moon_id' => params[:search])
		@material_list = @catalogs.distinct.pluck(:product_id)
		@mats_breakdown = Catalog.where('moon_id' => params[:search]).limit(@material_list.length)
		@chart_array = [[],[],[]]

		@repro_breakdown = Toolbox.repro_breakdown(@mats_breakdown).uniq
		Rails.logger.info "repro_list: " + @repro_breakdown.to_s

	end
	def flagged
		@catalogs = Catalog.paginate(:page => params[:page], :per_page => 75).where.not('flag' => nil).order(moon_esi: :asc, product: :asc, percent: :asc)
		@previous_entry = nil

		if params[:flagged_post] != nil and current_user.admin == true
			Toolbox.resolve_flagged(params[:flagged_post])
			redirect_to flagged_path
		end
	end
	def user_catalog
		@results = Catalog.paginate(:page => params[:page], :per_page => 75).where('user_id' => current_user).where.not('status' => nil || 3).order(moon_esi: :desc)
		@entry_results = @results.map(&:entry_id).uniq
		@mapped_results = @results.map(&:moon_id).uniq

		@material_results = Catalog.paginate(:page => params[:page], :per_page => 75).where('user_id' => current_user).where.not('status' => nil || 3).order(moon_esi: :desc).map(&:product).uniq
			@material_array = [[],[],[],[],[],[]]
			@material_results.each_with_index do |material, i|
			check = Toolbox.material_check(material)
				if check == 'material_R64'
					@material_array[5].push(material)
				elsif check == 'material_R32'
					@material_array[4].push(material)
				elsif check == 'material_R16'
					@material_array[3].push(material)
				elsif check == 'material_R8'
					@material_array[2].push(material)
				elsif check == 'material_R4'
					@material_array[1].push(material)
				elsif check == 'material_rock'
					@material_array[0].push(material)
				end
				Rails.logger.info 'Material Check: ' + check.to_s + " | " + material.to_s + " | " + i.to_s

			end

	end
	def dashboard
		@universe_size = Universe.all.size
		@catalog_size = Catalog.all.size
		@moons_size = Moon.all.size
		@entry_size = Entry.all.size
		@users_size = User.all.size

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
		if params[:search].to_s == ''
			redirect_to regions_path
			return
		end

		if params[:search] != nil
		# if params[:search] != nil && params[:region] == nil
			Rails.logger.info 'Search Check: ' +  params[:search].to_s
			# Check params for ID #
			if params[:search].to_s.scan(/\D/).empty? == true
				Rails.logger.info 'Redirect to Info Page: ' +  params[:search].to_s
				redirect_to info_path(search: params[:search])
				return
			end

			# Wildcard Search
			# @results = Catalog.where("system_esi LIKE ?", "%#{params[:search]}%").where.not('status' => nil)

			@results = Catalog.paginate(:page => params[:page], :per_page => 75).where("system_esi LIKE ?", "#{params[:search]}").where.not('status' => nil || 3).order(moon_esi: :desc)
			@entry_results = @results.map(&:entry_id).uniq
			@mapped_results = @results.map(&:moon_id).uniq

			@material_results = Catalog.where("system_esi LIKE ?", "#{params[:search]}").where.not('status' => nil || 3).order(moon_esi: :desc).map(&:product).uniq
			@material_array = [[],[],[],[],[],[]]
			@material_results.each_with_index do |material, i|
				check = Toolbox.material_check(material)
				if check == 'material_R64'
					@material_array[5].push(material)
				elsif check == 'material_R32'
					@material_array[4].push(material)
				elsif check == 'material_R16'
					@material_array[3].push(material)
				elsif check == 'material_R8'
					@material_array[2].push(material)
				elsif check == 'material_R4'
					@material_array[1].push(material)
				elsif check == 'material_rock'
					@material_array[0].push(material)
				end
				Rails.logger.info 'Material Check: ' + check.to_s + " | " + material.to_s + " | " + i.to_s

			end
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
		# @test = 'Local Regions'
	end
	def systems

		@systems = Universe.where('region_id' => params[:region]).order(system_name: :asc)

		# @region_list = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/regions/id/?datasource=singularity&language=en-us', params[:region])
		# Rails.logger.info @region_list.to_s
		# @region_list["constellations"].each do |i|


		# 	item = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/constellations/id/?datasource=singularity&language=en-us', i.to_s)
		# 	Rails.logger.info item

		# 	# @system_list.push(item)
		# end
	end
end