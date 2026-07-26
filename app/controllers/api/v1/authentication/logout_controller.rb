module Api
  module V1
    module Authentication
      class LogoutController < ApplicationController
        skip_before_action :authenticate_user!, raise: false

        def destroy
          head :no_content
        end
      end
    end
  end
end
