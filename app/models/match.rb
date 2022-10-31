# == Schema Information
#
# Table name: matches
#
#  id                   :bigint           not null, primary key
#  target_id            :bigint           not null
#  compatible_target_id :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_matches_on_compatible_target_id  (compatible_target_id)
#  index_matches_on_target_id             (target_id)
#
class Match < ApplicationRecord
  belongs_to :target
  belongs_to :compatible_target, class_name: 'Target', dependent: :destroy
  has_many :conversation, dependent: :destroy

  delegate :topic, to: :target
end
