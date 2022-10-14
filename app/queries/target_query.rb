class TargetQuery
  attr_reader :relation

  def initialize(relation = Target.all)
    @relation = relation
  end

  def compatible_target(target)
    relation.within(target.radius, origin: [target.latitude, target.longitude])
            .where(topic_id: target.topic_id, matched: false)
            .where.not(user_id: target.user_id)&.first
  end
end
