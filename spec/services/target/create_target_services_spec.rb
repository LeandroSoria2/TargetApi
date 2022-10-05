require 'rails_helper'

describe Targets::CreateService do
  describe '#call' do
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

      it 'increments the Targets count' do
        expect { subject }.to change { Target.count }.from(9).to(10)
      end

      it 'creates the Target with the right values' do
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

      it 'does not create a new target' do
        expect { subject }.to raise_error(MaxAllowTargetsError)
      end
    end

    context 'when two targets match' do
      let!(:target) do
        create(:target,
               latitude: target_params[:latitude],
               longitude: target_params[:longitude],
               topic_id: topic_id)
      end

      it 'creates a match' do
        expect { subject }.to change { Match.count }.from(0).to(1)
      end
    end

    context 'when two targets do not match' do
      context 'when they have a different topic' do
        let!(:target) do
          create(:target,
                 latitude: target_params[:latitude],
                 longitude: target_params[:longitude])
        end

        it 'does not create a connection' do
          expect { subject }.not_to change { Match.count }
        end
      end
    end

    context 'When is out of range' do
      let!(:target) do
        create(:target,
               topic_id: topic_id)
      end
      it 'does not create a match' do
        expect { subject }.not_to change { Match.count }
      end
    end

    context 'When they have the same user' do
      let!(:target) do
        create(:target,
               latitude: target_params[:latitude],
               longitude: target_params[:longitude],
               topic_id: topic_id,
               user: user)
      end
      it 'does not create a match' do
        expect { subject }.not_to change { Match.count }
      end
    end

    context 'when there is no other target' do
      it 'does not create a match' do
        expect { subject }.not_to change { Match.count }
      end
    end
  end
end
