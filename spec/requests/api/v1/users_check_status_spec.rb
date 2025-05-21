# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User check_status API', type: :request do
  let(:headers) do
    {
      'Content-Type': 'application/json',
      'CF-IPCountry': 'US'
    }
  end

  before do
    allow(Rails.cache).to receive(:fetch).and_return(['US'])
    allow(VpnApiClient).to receive(:check).and_return({ 'security' => { 'vpn' => false } })
    allow_any_instance_of(Factories::Loggers::IntegrityLoggerAdapter).to receive(:log)
  end

  it 'returns 200 and ban_status for valid request' do
    post '/api/v1/user/check_status',
         params: {
           idfa: SecureRandom.uuid,
           rooted_device: false
         }.to_json,
         headers: headers

    expect(response).to have_http_status(:ok)
    expect(response.parsed_body).to have_key('ban_status')
  end

  it 'returns 400 when CF-IPCountry header is missing' do
    post '/api/v1/user/check_status',
         params: {
           idfa: SecureRandom.uuid,
           rooted_device: false
         }.to_json,
         headers: { 'Content-Type': 'application/json' }

    expect(response).to have_http_status(:bad_request)
  end

  it 'returns 422 when idfa is missing' do
    post '/api/v1/user/check_status',
         params: { rooted_device: false }.to_json,
         headers: headers

    expect(response).to have_http_status(:unprocessable_entity)
  end

  it 'returns 400 when rooted_device is invalid' do
    post '/api/v1/user/check_status',
         params: {
           idfa: SecureRandom.uuid,
           rooted_device: 'maybe'
         }.to_json,
         headers: headers

    expect(response).to have_http_status(:bad_request)
  end
end
