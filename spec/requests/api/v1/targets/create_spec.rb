require 'rails_helper'

RSpec.describe 'POST api/v1/targets', type: :request do
  describe 'create a new target' do
    subject { post api_v1_targets_path, params: params, headers: headers, as: :json }

    let(:headers) { auth_headers }
    let(:user) { create(:user) }
    let!(:topic) { create(:topic) }
    let(:topic_id) { topic.id }

    let(:params) do
      { target: attributes_for(:target).merge(topic_id: topic_id) }
    end

    context 'when passed correct params' do
      it 'persists a target record' do
        expect { subject }.to change { Target.count }.by(1)
      end

      it 'returns status code created' do
        subject

        expect(response).to have_http_status(:ok)
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
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when radius is incorrect' do
        let(:params) do
          { target: attributes_for(:target).merge(topic_id: topic_id, radius: nil) }
        end

        it 'returns unprocessable entity' do
          subject
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when title is incorrect' do
        let(:params) do
          { target: attributes_for(:target).merge(topic_id: topic_id, title: nil) }
        end

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when longitude is incorrect' do
        let(:params) do
          { target: attributes_for(:target).merge(topic_id: topic_id, longitude: nil) }
        end

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:bad_request)
        end
      end

      context 'when latitude is incorrect' do
        let(:params) do
          { target: attributes_for(:target).merge(topic_id: topic_id, latitude: nil) }
        end

        it 'returns unprocessable entity' do
          expect(response).to have_http_status(:bad_request)
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

    context 'when the user has 9 targets' do
      let(:targets) { create_list(:target, 9, user: user) }
      it 'the target create correct' do
        subject
        expect(response).to have_http_status(:success)
      end
    end

    context 'when the user has 10 or more targets' do
      let!(:targets) { create_list(:target, 10, user: user) }
      it 'the target does not create' do
        subject
        expect(response.body).to include('exceeded number of targets limit')
      end
    end
  end
end
