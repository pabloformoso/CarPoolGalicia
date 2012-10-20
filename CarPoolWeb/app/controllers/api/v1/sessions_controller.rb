module Api
  module V1
    class SessionsController < Api::V1::BaseController
      
      before_filter :authenticate_user!, :except => [:create, :destroy]
      before_filter :ensure_params_exist
      
      respond_to :json

      def create
        resource = User.find_for_database_authentication(email: params[:user][:email])
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:user][:password])
          sign_in(:user, resource)
          render :json=> {success: true, id: resource.id, email: resource.email}
          return
        end
        invalid_login_attempt
      end

      def destroy
        resource = User.find_for_database_authentication(email: params[:user][:email])
        resource.authentication_token = nil
        resource.save
        render json: { success: true }
      end

      protected
      def ensure_params_exist
        return unless params[:user].blank?
        render :json=>{success: false, message: "missing user_login parameter"}, status: 422
      end

      def invalid_login_attempt
        render :json=> {success: false, message: "Error with your login or password"}, status: 401
      end
      
    end
  end
end