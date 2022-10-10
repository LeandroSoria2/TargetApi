require 'rails_helper'

describe TargetQuery do
  describe '#compatible_target' do
    subject do
      described_class.new.compatible_target(radius, latitude, longitude, topic_id, user_id)
    end
    let!(:target) do
      create(:target,
             latitude: target_params[:latitude],
             longitude: target_params[:longitude],
             topic_id: topic_id)
    end
  end
end
