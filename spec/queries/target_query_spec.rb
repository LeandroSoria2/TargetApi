require 'rails_helper'

describe TargetQuery do
  describe '#compatible_target' do
    subject do
      described_class.new.compatible_target(target)
    end
    let!(:user) { create(:user) }
    let!(:topic) { create(:topic) }
    let(:topic_id) { topic.id }

    let!(:target) do
      create(:target,
             radius: 20,
             latitude: 60,
             longitude: -60,
             topic_id: topic_id,
             matched: false)
    end

    context 'when there are targets in range' do
      let!(:new_target) do
        create(:target,
               radius: 25,
               latitude: 60,
               longitude: -60,
               topic_id: topic_id)
      end
      context 'when there are targets with same topic' do
        let!(:new_target) do
          create(:target,
                 radius: 25,
                 latitude: 60,
                 longitude: -60,
                 topic_id: topic_id)
        end
        context 'when there are targets with matched false' do
          let!(:new_target) do
            create(:target,
                   radius: 25,
                   latitude: 60,
                   longitude: -60,
                   topic_id: topic_id,
                   matched: false)
          end

          it 'does return complatible target' do
            expect(subject).to eq(new_target)
          end
        end
        context 'when there are targets with matched ture' do
          let!(:new_target) do
            create(:target,
                   latitude: 22.5,
                   longitude: -22.5,
                   topic_id: topic_id,
                   matched: true)
          end

          it 'return non matched targets' do
            expect(subject).to be nil
          end
        end
      end

      context 'when the target has not the same topic' do
        let!(:new_target) do
          create(:target,
                 latitude: 22.5,
                 longitude: -22.5)
        end
        it 'does not return targets matched' do
          expect(subject).to be nil
        end
      end
    end

    context 'when there are not targets in range' do
      let!(:new_target) do
        create(:target,
               latitude: 22.5,
               longitude: -22.5,
               topic_id: topic_id)
      end

      it 'return non matched targets in range' do
        expect(subject).to be nil
      end
    end
  end
end
