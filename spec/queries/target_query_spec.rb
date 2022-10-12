require 'rails_helper'

describe TargetQuery do
  describe '#compatible_target' do
    subject do
      described_class.new.compatible_target(new_target)
    end
    let!(:user) { create(:user) }
    let!(:topic) { create(:topic) }
    let(:topic_id) { topic.id }

    let(:new_target) do
      build(:target,
            radius: 25,
            latitude: 60,
            longitude: -60,
            topic_id: topic_id)
    end

    context 'when there are targets in range' do
      context 'when there are targets with the same topic' do
        context 'when there are targets without a match' do
          let!(:target) do
            create(:target,
                   radius: 20,
                   latitude: 60,
                   longitude: -60,
                   topic_id: topic_id,
                   matched: false)
          end

          it 'returns a complatible target' do
            expect(subject).to eq(target)
          end
        end

        context 'when there are not targets without a match' do
          let!(:target) do
            create(:target,
                   radius: 20,
                   latitude: 60,
                   longitude: -60,
                   topic_id: topic_id,
                   matched: true)
          end

          it 'does not return a compatible target' do
            expect(subject).to be nil
          end
        end
      end

      context 'when there are not targets with the same topic' do
        let!(:target) do
          create(:target,
                 radius: 20,
                 latitude: 60,
                 longitude: -60,
                 matched: false)
        end

        it 'does not return a compatible target' do
          expect(subject).to be nil
        end
      end
    end

    context 'when there are not targets in range' do
      let!(:target) do
        create(:target,
               radius: 20,
               latitude: 200,
               longitude: -200,
               topic_id: topic_id,
               matched: false)
      end
      it 'does not return a compatible target' do
        expect(subject).to be nil
      end
    end
  end
end
