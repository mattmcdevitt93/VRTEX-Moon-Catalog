class UsersController < ApplicationController
	before_action :admin_check, only: [:index]

  def index
  end
end