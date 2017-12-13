class Moon < ActiveRecord::Base
	belongs_to :catalog


	def self.Moon_Parse
		Rails.logger.info 'Moon Check'
		@moons = Moon.where('validation' => nil)
		@moons.each do |moon|
			begin
			valid = true
			Rails.logger.info "========================================"

			# Rails.logger.info moon.entry_id.to_s + " | " +  moon.product.to_s
			esi_product = Toolbox.EvE_Request("https://esi.tech.ccp.is/latest/universe/types/id/?datasource=singularity&language=en-us", moon.ore_type_id.to_s)["name"]
			esi_system = Toolbox.EvE_Request("https://esi.tech.ccp.is/latest/universe/systems/id/?datasource=singularity&language=en-us", moon.system_id.to_s)["name"]
			esi_planet = Toolbox.EvE_Request("https://esi.tech.ccp.is/latest/universe/planets/id/?datasource=singularity", moon.planet_id.to_s)["name"]
			esi_moon = Toolbox.EvE_Request("https://esi.tech.ccp.is/latest/universe/moons/id/?datasource=singularity", moon.moon_id.to_s)["name"]
			
			if esi_product != moon.product
				valid = false
			end	

			if 	esi_moon.to_s.split(/ /)[0] != esi_planet.to_s.split(/ /)[0] || esi_moon.to_s.split(/ /)[0] != esi_system.to_s.split(/ /)[0] || esi_planet.to_s.split(/ /)[0] != esi_system.to_s.split(/ /)[0]
				valid = false
			end

			Rails.logger.info esi_moon.to_s.split(/ /)[0] + " | " + esi_planet.to_s.split(/ /)[0] + " | " + esi_system.to_s.split(/ /)[0]
			Rails.logger.info esi_product.to_s + " | " + moon.product.to_s + " | " + moon.quantity.to_s
			Rails.logger.info "Catalog green light: " + valid.to_s

			if valid == true
				moon.update(validation: true)
				Rails.logger.info "Create Catalog Entry for " + moon.id.to_s + " | " + valid.to_s
				catalog_entry = Catalog.new do |u|
					u.entry_id = moon.entry_id.to_i
					u.user_id = moon.user_id.to_i
					u.system_id = moon.system_id.to_i
					u.system_esi =  esi_system
					u.planet_id = moon.planet_id.to_i
					u.planet_esi = esi_planet
					u.moon_id = moon.moon_id.to_i
					u.moon_esi = esi_moon
					u.product_id = moon.ore_type_id.to_i
					u.product = esi_product
					u.percent = moon.quantity
					# Universe.universe_update(moon.system_id.to_i)
				end
				catalog_entry.save

			else
				moon.update(validation: false)
			end
 			rescue
				Rails.logger.info "Moon Parse Error for " + moon.id.to_s
			end
		end
	end
end
