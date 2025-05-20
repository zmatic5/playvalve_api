class ApplicationController < ActionController::API
  rescue_from ActionController::BadRequest do |e|
    render json: { error: e.message }, status: :bad_request
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
