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
#  matched    :boolean          default(FALSE), not null
#
# Indexes
#
#  index_targets_on_title     (title) UNIQUE
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
require 'rails_helper'

RSpec.describe Target, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:matches) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:radius).only_integer }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:radius) }
  end
end
