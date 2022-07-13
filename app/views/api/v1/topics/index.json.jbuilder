json.topics @topics do |topic|
  json.partial! 'info', topic: topic
end
