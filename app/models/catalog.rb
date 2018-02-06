class Catalog < ActiveRecord::Base
	has_many :moons

	# Status notes
	# Level 0 - Null, no data avalable
	# Level 1 - One entry
	# Level 2 - Multi entries, verified
	# Level 3 - Multi entries, unequal quantity, flag
	# Level 4 - One entry, admin verified

		def self.catalog_parse
			Rails.logger.info 'Catalog Check'
			@unique_moons = Catalog.select(:moon_id).distinct
			@unique_moons.each do |moon|
				# Rails.logger.info moon.moon_id.to_s
				@target_moon = Catalog.where('moon_id' => moon.moon_id)
				@entry_array = []
				@product_array = []
				# Get the number of entries that include this object.
				@target_moon.each do |target|
					Rails.logger.info target.moon_esi.to_s + " | " + target.percent.to_s +  " | " + target.product_id.to_s + " | " + target.entry_id.to_s
					Universe.universe_update(target.system_id.to_i)

					@entry_array.push(target.entry_id)
					@product_array.push(target.product_id)
				end

				# States that one entry exists, it is not verified or has duplicates.
				if @entry_array.uniq.length.to_i == 1
					@target_moon.each do |target|
						target.update(status: 1)
					end
				else
					# If more than one entry exist.
					Rails.logger.info "Multiple Entries: " + @entry_array.uniq.length.to_s + " product_array: " + @product_array.uniq.length.to_s
						@product_array.uniq.each do |target|
							@multi_entry = Catalog.where('moon_id' => moon.moon_id, 'product_id' => target)
							Rails.logger.info target.to_s + " | " + @multi_entry.to_s
							@multi_product = []
							@multi_entry.each do |i|
								@multi_product.push(i.percent)
							end
							Rails.logger.info "Multi-product: " + @multi_product.uniq.length.to_s 
							if @multi_product.uniq.length == 1
								@target_moon.each do |target|
									target.update(status: 2)
								end
							else
								@target_moon.each do |target|
									if target.flag == nil
										user = User.find(target.user_id.to_i)
										total_flags = user.flags.to_i + 1
										Rails.logger.info "Flag Counter " + total_flags.to_s
										user.update(flags: total_flags)
									end
									target.update(status: 3, flag: true)
								end
							end

						end
				end

			end
		end
end
