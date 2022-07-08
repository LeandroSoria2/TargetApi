# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'validations' do
    subject { build(:topic) }

    it { is_expected.to validate_presence_of(:name) }
  end
end
