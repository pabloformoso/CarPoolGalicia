class HomeController < ApplicationController
  def index
    @carpools = Carpool.next_pools.order("departure asc")
  end
  
  def travelers
    @users = User.all
  end
end
