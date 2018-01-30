class Toolbox < ActiveRecord::Base

	def self.resolve_flagged (id)
			Rails.logger.info 'Resolved Flagged Post: ' +  id.to_s
			valid_entry = Catalog.find(id)
			valid_entry.update(flag: nil, status: 4)
			valid_entry.product
			results = Catalog.where('moon_id' => valid_entry.moon_id, 'product' => valid_entry.product)
			results.each do |r|
				if r.id != valid_entry.id 
					Rails.logger.info 'Deleted Post: ' +  r.id.to_s
					Catalog.destroy(r.id)
				end
			end
	end

	def self.EvE_Request (url, id)
		require 'net/http'
		require 'net/https'
		Rails.logger.info "EvE ESI check: " + url.to_s + " | " + id.to_s


			if id != nil
			url = url.gsub(/id/,id)
			end
		uri = URI.parse(url)
		request = Net::HTTP::Get.new(uri)
		request["Accept"] = "application/json"
		req_options = {
			use_ssl: uri.scheme == "https",
		}
		response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
			http.request(request)
		end
		return ActiveSupport::JSON.decode(response.body)

	end

	def self.EvE_Market (item_id)
		Rails.logger.info "EvE ESI Market Lookup: " + item_id.to_s
		# Rails.logger.info "Timestamp: " + Time.now.to_s + " | " + (Time.now-300).to_s  + " | " + $Timestamp.to_s
		$Timestamp = $Timestamp || nil
		if $Timestamp == nil || $Timestamp < Time.now-300
			Rails.logger.info "** Market Data Refresh **"
			$Market_Data = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/markets/prices/?datasource=tranquility', nil)
			$Timestamp = Time.now
		end 

		Rails.logger.info "Market Data: " + $Market_Data.length.to_s
		$Market_Data.each do |i|
			# Rails.logger.info i.to_s
			if i["type_id"] == item_id
				return i["adjusted_price"].to_f
			end
		end
		return nil
	end

	def self.material_check (data)
		# Rails.logger.info "Material Check: " + data.to_s
		if data.to_s.include?("Mercoxit")  || data.to_s.include?("Arkonor") || data.to_s.include?("Bistot") || data.to_s.include?("Crokite") || data.to_s.include?("Gneiss") || data.to_s.include?("Spodumain") || data.to_s.include?("Ochre")  || data.to_s.include?("Hemorphite") || data.to_s.include?("Hedbergite") || data.to_s.include?("Jaspet") || data.to_s.include?("Kernite") || data.to_s.include?("Omber") || data.to_s.include?("Plagioclase") || data.to_s.include?("Pyroxeres") || data.to_s.include?("Scordite") || data.to_s.include?("Veldspar")
			# Rails.logger.info "Material Check: Rock"
			return 'material_rock'
		end
		if data.to_s.include?("Bitumens") || data.to_s.include?("Coesite") || data.to_s.include?("Sylvite") || data.to_s.include?("Zeolites")
			return 'material_R4'
		end
		if data.to_s.include?("Cobaltite") || data.to_s.include?("Euxenite") || data.to_s.include?("Scheelite") || data.to_s.include?("Titanite")
			return 'material_R8'
		end
		if data.to_s.include?("Chromite") || data.to_s.include?("Otavite") || data.to_s.include?("Sperrylite") || data.to_s.include?("Vanadinite")
			return 'material_R16'
		end
		if data.to_s.include?("Zircon") || data.to_s.include?("Pollucite") || data.to_s.include?("Cinnabar") || data.to_s.include?("Carnotite")
			return 'material_R32'
		end
		if data.to_s.include?("Monazite") || data.to_s.include?("Loparite") || data.to_s.include?("Ytterbite") || data.to_s.include?("Xenotime")
			return 'material_R64'
		end
	end
	def self.material_color_check (data)
		# Rails.logger.info "Material Check: " + data.to_s
		if data.to_s.include?("Mercoxit")  || data.to_s.include?("Arkonor") || data.to_s.include?("Bistot") || data.to_s.include?("Crokite") || data.to_s.include?("Gneiss") || data.to_s.include?("Spodumain") || data.to_s.include?("Ochre")  || data.to_s.include?("Hemorphite") || data.to_s.include?("Hedbergite") || data.to_s.include?("Jaspet") || data.to_s.include?("Kernite") || data.to_s.include?("Omber") || data.to_s.include?("Plagioclase") || data.to_s.include?("Pyroxeres") || data.to_s.include?("Scordite") || data.to_s.include?("Veldspar")
			# Rails.logger.info "Material Check: Rock"
			return '#D3D3D3'
		end
		if data.to_s.include?("Bitumens") || data.to_s.include?("Coesite") || data.to_s.include?("Sylvite") || data.to_s.include?("Zeolites")
			return '#778899'
		end
		if data.to_s.include?("Cobaltite") || data.to_s.include?("Euxenite") || data.to_s.include?("Scheelite") || data.to_s.include?("Titanite")
			return 'green'
		end
		if data.to_s.include?("Chromite") || data.to_s.include?("Otavite") || data.to_s.include?("Sperrylite") || data.to_s.include?("Vanadinite")
			return '#0000FF'
		end
		if data.to_s.include?("Zircon") || data.to_s.include?("Pollucite") || data.to_s.include?("Cinnabar") || data.to_s.include?("Carnotite")
			return '#800080'
		end
		if data.to_s.include?("Monazite") || data.to_s.include?("Loparite") || data.to_s.include?("Ytterbite") || data.to_s.include?("Xenotime")
			return '#FFA500'
		end
	end


	def self.repro_breakdown (data)
		repro_data = []
		Rails.logger.info "Repro breakdown"
		data.each do |material|
			Rails.logger.info "Repro: " + material.product.to_s
			case material.product
			when 'Loparite'
				repro_data.push('Promethium', 'Platinum', 'Scandium', 'Hydrocarbons', 'Nocxium', 'Zydrine', 'Megacyte')
			when 'Monazite'
				repro_data.push('Neodinium', 'Chromium', 'Tungsten', 'Evaporite Deposits', 'Nocxium', 'Zydrine', 'Megacyte')
			when 'Xenotime'
				repro_data.push('Dysprosium', 'Vanadium', 'Cobalt', 'Atmospheric Gases', 'Nocxium', 'Zydrine', 'Megacyte')
			when 'Ytterbite'
				repro_data.push('Thulium', 'Cadmium ', 'Titanium', 'Silicates', 'Nocxium', 'Zydrine', 'Megacyte')

			when 'Zircon'
				repro_data.push('Hafnium', 'Titanium', 'Silicates', 'Mexallon', 'Isogen', 'Megacyte')
			when 'Pollucite'
				repro_data.push('Caesium', 'Scandium', 'Hydrocarbons', 'Mexallon', 'Isogen', 'Zydrine')
			when 'Cinnabar'
				repro_data.push('Mercury', 'Tungsten', 'Evaporite Deposits', 'Mexallon', 'Isogen', 'Megacyte')
			when 'Carnotite'
				repro_data.push('Technetium', 'Cobalt', 'Atmospheric Gases', 'Silicates', 'Mexallon', 'Isogen', 'Zydrine')

			when 'Chromite'
				repro_data.push('Chromium', 'Hydrocarbons', 'Pyerite', 'Mexallon', 'Isogen', 'Nocxium')
			when 'Otavite'
				repro_data.push('Cadmium', 'Atmospheric Gases', 'Tritanium', 'Mexallon', 'Isogen', 'Nocxium')
			when 'Sperrylite'
				repro_data.push('Platinum', 'Evaporite Deposits', 'Tritanium', 'Mexallon', 'Isogen', 'Zydrine')
			when 'Vanadinite'
				repro_data.push('Vanadium', 'Silicates', 'Pyerite', 'Mexallon', 'Isogen', 'Zydrine')

			when 'Cobaltite'
				repro_data.push('Cobalt', 'Tritanium', 'Pyerite', 'Mexallon')
			when 'Euxenite'
				repro_data.push('Scandium', 'Tritanium', 'Pyerite', 'Mexallon')
			when 'Scheelite'
				repro_data.push('Tungsten', 'Tritanium', 'Pyerite', 'Mexallon')
			when 'Titanite'
				repro_data.push('Titanium', 'Tritanium', 'Pyerite', 'Mexallon')			

			when 'Bitumens'
				repro_data.push('Hydrocarbons', 'Tritanium', 'Pyerite', 'Mexallon')
			when 'Coesite'
				repro_data.push('Silicates', 'Tritanium', 'Pyerite', 'Mexallon')
			when 'Sylvite'
				repro_data.push('Evaporite Deposits', 'Tritanium', 'Pyerite', 'Mexallon')
			when 'Zeolites'
				repro_data.push('Atmospheric Gases', 'Tritanium', 'Pyerite', 'Mexallon')		

			end
		end
		return repro_data
	end

	def self.universe_update 
		Rails.logger.info ' + Universe Update + '
		Universe.destroy_all
		@regions = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/regions/?datasource=tranquility', nil)
		@regions.each do |region|
			Rails.logger.info "Region Look up" + region.to_s
			@region_details = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/regions/id/?datasource=tranquility&language=en-us', region.to_s)
			# Rails.logger.info "Const Look up" + @region_details['constellations'].to_s

			if @region_details['name'].to_s.scan(/\d/).empty? == true
				
				@region_details['constellations'].each do |const|
					# Rails.logger.info "const Look up: " + const.to_s
					@const_details = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/constellations/id/?datasource=tranquility&language=en-us', const.to_s)
					@const_details['systems'].each do |system|
						@system_details = Toolbox.EvE_Request('https://esi.tech.ccp.is/latest/universe/systems/id/?datasource=tranquility&language=en-us', system.to_s)
						Rails.logger.info "Create Entry: " + @region_details['name'].to_s + " | " + @const_details['name'].to_s + " | " + @system_details['name'].to_s
						universe_entry = Universe.new do |u|
							u.region_id = @region_details['region_id'].to_i
							u.region_name = @region_details['name'].to_s
							u.constellation_id = @const_details['constellation_id'].to_s
							u.constellation_name = @const_details['name'].to_s
							u.system_id = @system_details['system_id'].to_s
							u.system_name = @system_details['name'].to_s
						end
					universe_entry.save
					end
				end

			else
				Rails.logger.info ' + J-space Region (skipping for catalog) + '
			end

		end
	end

end
