class TargetQuery
  attr_reader :relation

  def initialize(relation = Target.all)
    @relation = relation
  end

  def compatible_target(radius, latitude, longitude, topic_id, user_ids)
    relation.within(radius, origin: [latitude, longitude])
            .where(topic_id: topic_id)
            .where.not(user_id: user_ids)&.first
  end
end
