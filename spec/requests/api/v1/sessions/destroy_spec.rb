describe 'DELETE aapi/v1/auth/sign_out', type: :request do
  let(:user) { create(:user) }

  subject { delete destroy_api_v1_user_session_path, headers: headers, as: :json } 
  context 'with a valid token' do
    let(:headers) { auth_headers }
    it 'returns a successful response' do
      subject
      expect(response).to have_http_status(:success)
    end

    it 'decrements the amount of user tokens' do
      headers = auth_headers
      expect {
        subject
      }.to change { user.reload.tokens.size }.by(-1)
    end
  end

  context 'without a valid token' do
    let(:headers) {}
    it 'returns not found response' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end
end 
