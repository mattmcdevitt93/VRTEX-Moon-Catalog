class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  def self.Admin_initialize
    Rails.logger.info 'Admin Check'
    initial_user = User.where(admin: true)
    if initial_user == []
      Rails.logger.info "Resetting Admin Permissions"
      user = User.find(1)
      user.update(admin: true)
    end
  end

end
