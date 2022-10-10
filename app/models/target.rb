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
#  matched    :boolean
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

  belongs_to :user
  belongs_to :topic
  has_many :matches, dependent: :destroy
  has_many :compatible_targets, through: :matches

  validates :title, :longitude, :latitude, :radius, presence: true
  validates :radius, numericality: { only_integer: true }
end
