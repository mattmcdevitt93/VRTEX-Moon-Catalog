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

end
