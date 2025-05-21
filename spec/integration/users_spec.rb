require 'swagger_helper'

RSpec.describe 'User Ban Check API', type: :request do
  path '/api/v1/user/check_status' do
    post('check_status') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'CF-IPCountry',
                in: :header,
                type: :string,
                required: true,
                description: 'Country code from Cloudflare',
                example: 'US'

      parameter name: :params,
                in: :body,
                schema: {
                  type: :object,
                  properties: {
                    idfa: {
                      type: :string,
                      example: '8264148c-be95-4b2b-b260-6ee98dd53bf6'
                    },
                    rooted_device: {
                      type: :boolean,
                      example: false
                    }
                  },
                  required: ['idfa', 'rooted_device']
                }

      response(200, 'successful') do
        let(:'CF-IPCountry') { 'US' }
        let(:params) do
          {
            idfa: '8264148c-be95-4b2b-b260-6ee98dd53bf6',
            rooted_device: false
          }
        end

        run_test!
      end

      response(400, 'missing CF-IPCountry header') do
        let(:'CF-IPCountry') { nil }
        let(:params) do
          {
            idfa: '8264148c-be95-4b2b-b260-6ee98dd53bf6',
            rooted_device: false
          }
        end

        run_test!
      end

      response(422, 'missing rooted_device param') do
        let(:'CF-IPCountry') { 'US' }
        let(:params) do
          {
            idfa: '8264148c-be95-4b2b-b260-6ee98dd53bf6'
          }
        end

        run_test!
      end
    end
  end
end
