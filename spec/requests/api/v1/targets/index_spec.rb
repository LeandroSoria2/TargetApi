require 'rails_helper'

describe 'GET api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers }
  let(:parsed_response) { JSON.parse(response.body) }

  subject { get api_v1_targets_path, as: :json, headers: headers }
  context 'when user has targets' do
    let(:num_of_targets) { Faker::Number.between(from: 1, to: 10) }
    let!(:targets) { create_list(:target, num_of_targets, user: user) }

    before { subject }

    it 'returns status code ok' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all the user targets' do
      expect(json[:targets].size).to eq(num_of_targets)
    end
  end

  context 'when user does not have targets' do
    before { subject }

    it 'returns an empty array' do
      expect(json[:targets]).to be_empty
    end
  end

  context 'when user is not signed in' do
    let(:headers) { {} }

    before { subject }

    it 'returns unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
