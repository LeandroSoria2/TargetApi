require 'rails_helper'

describe 'DELETE api/v1/targets/:id' do
  let(:user) { create(:user) }
  let(:headers) { auth_headers }
  let!(:target) { create(:target, user: user) }
  let(:target_id) { target.id }

  subject { delete api_v1_target_path(id: target_id), as: :json, headers: headers }

  context 'when user sends own target id' do
    it 'returns ok' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'deletes the target' do
      expect {
        subject
      }.to change { Target.count }.by(-1)
    end
  end

  context 'when user sends someone elses target id' do
    let(:target_id) { -1 }

    it 'returns not_found' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end
end
