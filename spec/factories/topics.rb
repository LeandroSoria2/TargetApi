# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :topic do
    name { Faker::Lorem.unique.word }

    trait :with_image do
      image { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/li_.png')) }
    end
  end
end
