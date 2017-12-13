class Universe < ActiveRecord::Base

	def self.universe_update (system_id)
		Rails.logger.info "universe_update system: " + system_id.to_s
		@system = Universe.where('system_id' => system_id)
		if @system[0].content == nil
			@system[0].update(content: true)
		end
	end
end
