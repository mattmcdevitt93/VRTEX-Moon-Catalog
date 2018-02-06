#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

$s = Rufus::Scheduler.singleton
Rails.logger.info "Singleton Start"

$s.every '15m' do
	Moon.Moon_Parse
end  

$s.every '1h' do
	Catalog.catalog_parse
end