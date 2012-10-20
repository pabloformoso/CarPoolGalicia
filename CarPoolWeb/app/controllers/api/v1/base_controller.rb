module Api
  module V1
    class BaseController < ApplicationController
      skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }      
      respond_to :json
      
      def test
        respond_with "{Prueba}"
      end
    end    
  end
end