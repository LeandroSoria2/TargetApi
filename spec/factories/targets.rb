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
FactoryBot.define do
  factory :target do
    title { Faker::Science.science }
    radius { Faker::Number.between(from: 1, to: 1000) }
    longitude { Faker::Address.longitude }
    latitude { Faker::Address.latitude }
    topic
    user
  end
end
