# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  topic_id   :bigint           not null
#  user_id    :bigint           not null
#  title      :string           not null
#  radius     :integer          not null
#  longitude  :decimal(, )      not null
#  latitude   :decimal(, )      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_targets_on_title     (title) UNIQUE
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
class Target < ApplicationRecord
  acts_as_mappable lat_column_name: :latitude,
                   lng_column_name: :longitude

  belongs_to :topic
  belongs_to :user

  validates :title, :longitude, :latitude, :radius, presence: true
  validates :radius, numericality: { only_integer: true }
  validate :number_of_user_targets

  private

  def number_of_user_targets
    errors.add(:user, 'exceeded number of targets limit') if user&.targets_limit_exceeded?
  end
end
