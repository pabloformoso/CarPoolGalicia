module Api
  module V1
    class PoolController < Api::V1::BaseController
      
      #List all pools
      def all_pools
        @pools = Carpool.all  
        if @pools.size > 0
          respond_with @pools.to_json(
              :include => {:users => {:only => [:id, :name, :lastname, :email]}},
              :methods => [:driver_info, :seats_available],
              :include_root_in_json => :false
          )
        else
          respond_with "{error: 1, message: 'Not pools found'}"
        end      

      end
      
      # Detail pool
      def get_pool
        @pool = Carpool.find params[:id]
        if @pool
          respond_with @pool.to_json(
            :include => {:users => {:only => [:id, :name, :lastname, :email]}},
            :methods => [:driver_info, :seats_available],
            :include_root_in_json => :false
          )
        else
          respond_with "{error: 1, message: 'Pool not found'}"
        end
      end
      
      # Locates from start point
      def locate_pools
        @pool = Carpool.search(:start_address_contains => params[:search])
        @results = @pool.all
        if @pool
          respond_with @results.to_json(
            :include => {:users => {:only => [:id, :name, :lastname, :email]}},
            :methods => [:driver_info, :seats_available],
            :include_root_in_json => :false
          )
        else
          respond_with "{error: 1, message: 'Not pools found'}"
        end
      end
      
      #Join a Pool
      def join
        user = User.find params[:user_id]
        pool = Carpool.find params[:pool_id]
        
        if !pool
          respond_with "{error: 1, message: 'Not pools found'}"
          return
        end
        
        if pool.is_compleate?
          pool.users << user
          if pool.save
            respond_with pool.to_json(
              :include => {:users => {:only => [:id, :name, :lastname, :email]}},
              :methods => [:driver_info, :seats_available],
              :include_root_in_json => :false
            )
          else
            respond_with "{error: 1, message: 'Not addeded to the pool'}"
          end
        else
          respond_with "{error: 1, message: 'Carpool is full'}"
        end
      end
      
      def create
        pool = Carpool.new(params[:carpool], without_protection: true)
        if pool.save 
          respond_with pool.to_json(
            :include => {:users => {:only => [:id, :name, :lastname, :email]}},
            :methods => [:driver_info, :seats_available],
            :include_root_in_json => :false
          )
        else
          respond_with "{error: 1, message: 'Pool not created'}"
        end
      end
      
      def by_user
        @pools = Carpool.find_all_by_driver_id params[:id]
        if @pools.size > 0
          respond_with @pools.to_json(
              :include => {:users => {:only => [:id, :name, :lastname, :email]}},
              :methods => [:driver_info, :seats_available],
              :include_root_in_json => :false
          )
        else
          respond_with "{error: 1, message: 'Not pools found'}"
        end
      end
    end
  end
end
