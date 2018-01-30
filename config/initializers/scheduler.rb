#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

$s = Rufus::Scheduler.singleton
Rails.logger.info "Singleton Start"

# $s.every '15m' do
# 	User.Admin_initialize()
# end  