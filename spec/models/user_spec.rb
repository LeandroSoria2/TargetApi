# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  email                  :string           not null
#  encrypted_password     :string           default(""), not null
#  gender                 :integer
#  image                  :string
#  lastname               :string
#  name                   :string
#  nickname               :string
#  provider               :string           default("email"), not null
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }
    it 'validates gender enum field' do
      is_expected.to define_enum_for(:gender)
        .with_values(female: 0,
                     male: 1,
                     fluid: 2)
        .backed_by_column_of_type(:integer)
    end
  end
end
