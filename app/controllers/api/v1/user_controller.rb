module Api
  module V1
    class UserController < ApplicationController
      def check_status
        user = BanCheckService.new(
          idfa: params[:idfa],
          rooted_device: params[:rooted_device],
          ip: request.remote_ip,
          country: request.headers['CF-IPCountry']
        ).call

        render json: { ban_status: user.ban_status }, status: :ok
      rescue => e
        Rails.logger.error("check_status error: #{e.message}")
        render json: { error: 'Internal server error' }, status: :internal_server_error
      end
    end
  end
end
