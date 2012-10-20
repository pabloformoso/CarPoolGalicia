class Carpool < ActiveRecord::Base
  
  belongs_to :driver, :class_name => "User", :foreign_key => "driver_id"
  has_and_belongs_to_many :users, :join_table => "carpools_users"
  
  attr_accessible :departure, :destination_address, :seats, :start_address, :driver_id
  
  scope :next_pools, lambda { where("departure > ?", Time.zone.now ) }
  
  def driver_info
    driver
  end
  
  def is_compleate?
    users.size != seats
  end
  
  def seats_available
    if !is_compleate?
      0
    else
      seats - users.size
    end
  end
  
  def cost
    (rand(10) * 1.50) / seats
  end
end
