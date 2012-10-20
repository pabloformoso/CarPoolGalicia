module Api
  module V1
    class RegistrationsController < Api::V1::BaseController
  
      respond_to :json
      
      def create
        user = User.new(params[:user], without_protection: true)
        if user.save
          render json: user.as_json(id: user.id, email: user.email), status: 201
          return
        else
          puts user.errors
          warden.custom_failure!
          render json: user.errors
        end
      end
    end
  end
end