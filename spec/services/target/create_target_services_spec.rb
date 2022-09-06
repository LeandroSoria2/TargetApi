require 'rails_helper'

describe Targets::CreateService do
  describe '' do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic) }
    let(:topic_id) { topic.id }

    let(:target_params) do
      attributes_for(:target).merge(topic_id: topic_id)
    end

    subject do
      Targets::CreateService.new(user, target_params).call
    end

    context 'when the user has 9 targets' do
      let!(:targets) { create_list(:target, 9, user: user) }

      it 'increment the Targets count' do
        expect { subject }.to change { Target.count }.from(9).to(10)
      end

      it 'create the Target with tie right values' do
        subject
        last_target = Target.last

        expect(last_target.title).to eq(target_params[:title])
        expect(last_target.radius).to eq(target_params[:radius])
        expect(last_target.longitude).to eq(target_params[:longitude])
        expect(last_target.latitude).to eq(target_params[:latitude])
        expect(last_target.topic_id).to eq(target_params[:topic_id])
      end
    end

    context 'when the user has 10 or more targets' do
      let!(:targets) { create_list(:target, 10, user: user) }

      it 'the target does not create' do
        expect { subject }.to raise_error(MaxAllowTargetsError)
      end
    end
  end
end
