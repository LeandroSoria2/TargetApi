# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  name                   :string
#  lastname               :string
#  nickname               :string
#  image                  :string
#  email                  :string
#  gender                 :integer
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  targets_count          :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  MAX_ALLOWED_TARGETS = 10

  enum gender: { female: 0, male: 1, fluid: 2 }
  has_many :targets, dependent: :destroy
  validates :gender, presence: true

  def targets_limit_exceeded?
    targets.count >= MAX_ALLOWED_TARGETS
  end
end
