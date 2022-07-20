require 'rails_helper'

describe 'GET api/v1/topics', type: :request do
  let(:user) { create(:user) }
  let!(:headers) { auth_headers }
  let!(:topics) { create_list(:topic, 3) }

  subject { get api_v1_topics_path, headers: headers, as: :json }
  before { subject }

  context 'when there are topics' do
    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct amount of topics' do
      expect(json[:topics].size).to eq(3)
    end

    it 'returns all the topics' do
      subject
      expect(json[:topics].pluck(:id, :name)).to match_array(topics.pluck(:id, :name))
    end
  end

  context 'when there are no topics' do
    let(:topics) {}
    it 'returns a successful response' do
      expect(response).to have_http_status(:success)
    end

    it 'returns an empty array' do
      expect(json[:topics]).to be_empty
    end
  end

  context 'when there is no logged-in user' do
    let(:headers) {}
    it 'retuns unauthorized' do
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
