#
# config/initializers/scheduler.rb
require 'rufus-scheduler'

$s = Rufus::Scheduler.singleton

$s.every '15m' do
	User.Admin_initialize()
end  