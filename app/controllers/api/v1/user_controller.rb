module Api
  module V1
    class UserController < ApplicationController
      before_action :assign_request_data

      def check_status
        user = BanCheckService.new(**ban_check_params).call
        render json: { ban_status: user.ban_status }, status: :ok
      end

      private

      def assign_request_data
        Current.ip = request.remote_ip
        Current.rooted_device = permitted_params[:rooted_device]
        Current.country = request.headers['CF-IPCountry']
      end

      def ban_check_params
        permitted_params
          .to_h
          .symbolize_keys
          .merge(
            ip: request.remote_ip,
            country: request.headers['CF-IPCountry']
          )
      end

      def permitted_params
        params.permit(:idfa, :rooted_device)
      end
    end
  end
end
