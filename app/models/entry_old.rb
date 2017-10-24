
	def self.EvE_Request (url, id) 
		require 'net/http'
		require 'uri'
		url = url.gsub(/id/,id)
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

	def self.input_check (content)
		formatted_content = content.split("\n")
		formatted_content.each_with_index do |target, i|
			if i != 0
				# Rails.logger.info i.to_s + "=================="
				if target.first == "\t"
					scan_results = target.gsub(/\r/,"").split("\t")
					Rails.logger.info "Material: " + scan_results.to_s
				end
			end
		end
		return true
	end


	def self.format_check (content)
		Rails.logger.info "Format Verfication Check"
		begin
			formatted_content = content.split("\n")
			formatted_content.each_with_index do |target, i|
				if i != 0
				# Rails.logger.info i.to_s + "=================="
				if target.first == "\t"
					scan_results = target.gsub(/\r/,"").split("\t")
					scan_results[2] = (scan_results[2].to_f * 100).round(0)
					scan_results[3] = EvE_Request("https://esi.tech.ccp.is/latest/universe/types/id/?datasource=singularity&language=en-us", scan_results[3])["name"]
					scan_results[4] = EvE_Request("https://esi.tech.ccp.is/latest/universe/systems/id/?datasource=singularity&language=en-us", scan_results[4])["name"]
					scan_results[5] = EvE_Request("https://esi.tech.ccp.is/latest/universe/planets/id/?datasource=singularity", scan_results[5])["name"]
					scan_results[6] = EvE_Request("https://esi.tech.ccp.is/latest/universe/moons/id/?datasource=singularity", scan_results[6])["name"]
					if scan_results[5].first(5) == scan_results[6].first(6) && scan_results[5].first(5) == scan_results[7].first(5)
						scan_results[0] = true
					else
						scan_results[0] = false	
					end
					Rails.logger.info "Material: " + scan_results.to_s
				end
			end
		end
		return true
	rescue
		Rails.logger.info "Validation Error"
		return false
	end
end

