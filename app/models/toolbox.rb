class Toolbox < ActiveRecord::Base

	def self.EvE_Request (url, id) 
		Rails.logger.info "EvE ESI check: " + url.to_s + " | " + id.to_s
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

	def self.material_check (data)
		Rails.logger.info "Material Check: " + data.to_s
		if data.to_s.include?("Mercoxit")  || data.to_s.include?("Arkonor") || data.to_s.include?("Bistot") || data.to_s.include?("Crokite") || data.to_s.include?("Gneiss") || data.to_s.include?("Spodumain") || data.to_s.include?("Ochre")  || data.to_s.include?("Hemorphite") || data.to_s.include?("Hedbergite") || data.to_s.include?("Jaspet") || data.to_s.include?("Kernite") || data.to_s.include?("Omber") || data.to_s.include?("Plagioclase") || data.to_s.include?("Pyroxeres") || data.to_s.include?("Scordite") || data.to_s.include?("Veldspar")
			Rails.logger.info "Material Check: Rock"
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

end
