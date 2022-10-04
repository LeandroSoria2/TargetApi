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
require 'rails_helper'

describe Match, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:target) }
    it { is_expected.to belong_to(:compatible_target).class_name('Target') }
  end
end
