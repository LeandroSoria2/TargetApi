require 'rails_helper'

RSpec.describe 'POST api/v1/auth/sign_in', type: :request do
  subject { post user_session_path, params: params, as: :json }

  let(:password) { 'password' }
  let(:user) { create(:user, password: password) }
  let(:params) do
    {
      user:
        {
          email: user.email,
          password: password
        }
    }
  end

  context 'with correct params' do
    before do
      subject
    end

    it_behaves_like 'there must not be a Set-Cookie in Header'
    it_behaves_like 'does not check authenticity token'

    it 'returns success' do
      expect(response).to be_successful
    end

    it 'returns the user' do
      expect(json[:user][:email]).to eq(user.email)
      expect(json[:user][:uid]).to eq(user.uid)
      expect(json[:user][:provider]).to eq('email')
      expect(json[:user][:name]).to eq(user.name)
      expect(json[:user][:lastname]).to eq(user.lastname)
      expect(json[:user][:gender]).to eq(user.gender)
    end

    it 'returns a valid client and access token' do
      token = response.header['access-token']
      client = response.header['client']
      expect(user.reload.valid_token?(token, client)).to be_truthy
    end
  end

  context 'with incorrect password' do
    let(:params) do
      {
        user: {
          email: user.email,
          password: 'wrong_password!'
        }
      }
    end

    it 'return errors upon failure' do
      subject

      expect(response).to be_unauthorized
      expected_response = {
        errors: ['Invalid login credentials. Please try again.'],
        success: false
      }.with_indifferent_access
      expect(json).to eq(expected_response)
    end
  end

  context 'with incorrect email' do
    let(:params) do
      {
        user: {
          email: 'mail@mail.com',
          password: user.password
        }
      }
    end

    it 'return errors upon failure' do
      subject

      expect(response).to be_unauthorized
      expected_response = {
        errors: ['Invalid login credentials. Please try again.'],
        success: false
      }.with_indifferent_access
      expect(json).to eq(expected_response)
    end
  end
end
