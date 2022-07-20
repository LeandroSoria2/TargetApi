require 'rails_helper'

describe 'POST api/v1/auth', type: :request do
  let(:user)            { User.last }
  let(:failed_response) { 422 }

  describe 'POST create' do
    subject { post user_registration_path, params: params, as: :json }

    let(:user_data) { build(:user) }
    let(:email) { user_data.email }
    let(:password) { user_data.password }
    let(:password_confirmation) { user_data.password_confirmation }
    let(:gender) { user_data.gender }

    let(:params) do
      {
        user: {
          email: email,
          password: password,
          password_confirmation: password_confirmation,
          gender: gender
        }
      }
    end

    it_behaves_like 'does not check authenticity token'
    it_behaves_like 'there must not be a Set-Cookie in Header'

    it 'returns a successful response' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'creates the user' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'returns the user' do
      subject

      expect(json[:user][:id]).to eq(user.id)
      expect(json[:user][:email]).to eq(user_data.email)
      expect(json[:user][:uid]).to eq(user_data.email)
      expect(json[:user][:provider]).to eq('email')
      expect(json[:user][:gender]).to eq(user_data.gender)
    end

    context 'when the email is not correct' do
      let(:email) { 'invalid_email' }

      it 'does not create a user' do
        expect { subject }.not_to change { User.count }
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the password is incorrect' do
      let(:password)              { 'short' }
      let(:password_confirmation) { 'short' }
      let(:new_user)              { User.find_by(email: email) }

      it 'does not create a user' do
        subject
        expect(new_user).to be_nil
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when passwords don\'t match' do
      let(:password)              { 'shouldmatch' }
      let(:password_confirmation) { 'dontmatch' }
      let(:new_user)              { User.find_by(email: email) }

      it 'does not create a user' do
        subject
        expect(new_user).to be_nil
      end

      it 'does not return a successful response' do
        subject
        expect(response.status).to eq(failed_response)
      end
    end

    context 'when the gender is not correct' do
      let(:gender) { 'invalid_gender' }

      it 'does not create a user' do
        expect { subject }.to raise_error(ArgumentError).and(change(User, :count).by(0))
      end
    end
  end
end
