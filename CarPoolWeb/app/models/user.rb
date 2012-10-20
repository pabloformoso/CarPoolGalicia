class User < ActiveRecord::Base
  ActiveRecord::Base.include_root_in_json = false
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :lastname, :phone_number, :city
  
  belongs_to :driver, :class_name => "Carpool", :foreign_key => "driver_id"
  has_and_belongs_to_many :carpools
end
