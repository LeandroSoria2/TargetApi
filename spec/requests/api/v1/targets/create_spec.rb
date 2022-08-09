require 'rails_helper'

RSpec.describe 'POST api/v1/targets', type: :request do
  describe 'create a new target' do
    subject { post api_v1_targets_path, params: params, headers: headers, as: :json }

    let(:headers) { auth_headers }
    let(:user) { create(:user) }
    let(:topic) { create(:topic) }
    let(:title) { Faker::Science.science }
    let(:radius) { Faker::Number.between(from: 1, to: 1000) }
    let(:longitude) { Faker::Address.longitude.round(14).to_s }
    let(:latitude) { Faker::Address.latitude.round(14).to_s }
    let(:topic_id) { topic.id }
    let(:params) do
      {
        target:
        {
          topic_id: topic_id,
          title: title,
          radius: radius,
          longitude: longitude,
          latitude: latitude
        }
      }
    end

    context 'when passed correct params' do
      it 'persist a target record' do
        expect { subject }.to change { Target.count }.by(1)
      end

      it 'returns status code created' do
        subject

        expect(response).to have_http_status(200)
      end

      it 'associates the target to current_user' do
        subject

        expect(Target.last.user).to eq(user)
      end
    end

    context 'when params are incorrect' do
      before { subject }

      context 'when topic does not exist' do
        let(:topic_id) { nil }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when radius is incorrect' do
        let(:radius) { nil }

        it 'returns unprocessable entity' do
          subject
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when title is incorrect' do
        let(:title) { nil }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when longitude is incorrect' do
        let(:longitude) { nil }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end

      context 'when latitude is incorrect' do
        let(:latitude) { nil }

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not logged in' do
      let(:headers) { {} }
      it 'returns unauthorized' do
        subject
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
