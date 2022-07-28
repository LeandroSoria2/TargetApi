require 'rails_helper'

describe 'GET api/v1/topics', type: :request do
  let(:user) { create(:user) }
  let!(:headers) { auth_headers }

  subject { get api_v1_topics_path, headers: headers, as: :json }
  context 'when there are topics' do
    let!(:topics) { create_list(:topic, 3, :with_image) }

    it 'returns a successful response' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'returns the correct amount of topics' do
      subject

      expect(json[:topics].size).to eq(3)
    end

    it 'returns all the topics' do
      subject

      expect(json[:topics].pluck(:id, :name)).to match_array(topics.pluck(:id, :name))
    end

    it 'returns the image in the body response' do
      subject
      json[:topics].each do |topic|
        expect(topic[:image_url]).to match(/li_.png/)
      end
    end
  end

  context 'When there are topics without image' do
    let!(:topics_no_image) { create_list(:topic, 3) }

    it 'does not return an image_url in the body response' do
      subject
      json[:topics].each do |topic|
        expect(topic[:image_url]).not_to match(/li_.png/)
      end
    end
  end

  context 'when there are no topics' do
    let(:topics) {}
    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'returns an empty array' do
      subject
      expect(json[:topics]).to be_empty
    end
  end

  context 'when there is no logged-in user' do
    let(:headers) {}
    it 'retuns unauthorized' do
      subject
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
