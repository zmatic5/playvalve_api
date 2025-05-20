module Api
  module V1
    class UsersController < ApplicationController
      before_action :require_country_header!

      def check_status
        idfa = validate_idfa!(params.require(:idfa))
        rooted_device = validate_rooted_device!(params.require(:rooted_device))

        user = UserCheckFlow.new(
          idfa: idfa,
          rooted_device: rooted_device,
          ip: request.remote_ip,
          country: request.headers['CF-IPCountry']
        ).call

        render json: { ban_status: user.ban_status }, status: :ok
      end

      private

      def require_country_header!
        raise ActionController::BadRequest, "Missing CF-IPCountry header" if request.headers['CF-IPCountry'].blank?
      end

      def validate_idfa!(value)
        unless value.is_a?(String) && value.match?(/\A[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}\z/i)
          raise ActionController::BadRequest, "idfa must be a valid UUID"
        end

        value.downcase
      end

      def validate_rooted_device!(value)
        case value
        when true, "true" then true
        when false, "false" then false
        else
          raise ActionController::BadRequest, "rooted_device must be true or false"
        end
      end
    end
  end
end
