require_relative '../acceptance_tests_helper'

resource 'Topics' do
  header 'Content-Type', 'application/json'
  header 'access-token', :access_token_header
  header 'client',       :client_header
  header 'uid',          :uid_header
  header 'expiry',       :expiry_header
  header 'token-type',   :token_type_header

  let!(:user) { create(:user) }

  route '/api/v1/topics', 'Index topics' do
    let!(:topic) { create_list(:topic, 3) }
    let(:request) {}

    get 'Index' do
      context 'when response status is 200' do
        example 'Index - OK - Without params' do
          do_request

          expect(status).to eq(200)
        end
      end
    end
  end
end
