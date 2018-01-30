class Entry < ActiveRecord::Base
	 validates :content, :presence => true

	def self.format_check (content, id, user)
		Rails.logger.info "Format Verfication Check"
		formatted_content = content.split("\n")
		formatted_content.each_with_index do |target, i|
			valid = true
				if target.first == "\t"
					scan_results = target.gsub(/\r/,"").split("\t")
					Rails.logger.info "Material check: " + scan_results.to_s
					if scan_results[0] != "" || scan_results[2].to_i > 1 || scan_results[3].length != 5 || scan_results[4].length != 8 || scan_results[5].length != 8 || scan_results[6].length != 8
						valid = false
					end
				else
					valid = false
				end
			Rails.logger.info "Create Moon Entry:" + id.to_s + " | " +  valid.to_s
			if valid == true
				Moon.create :user_id => user.to_i, :entry_id => id.to_i, :product => scan_results[1], :quantity => scan_results[2].to_f, :ore_type_id => scan_results[3].to_i, :system_id => scan_results[4].to_i, :planet_id => scan_results[5].to_i, :moon_id => scan_results[6]
			end
		end
	end

end