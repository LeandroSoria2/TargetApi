json.id        topic.id
json.name      topic.name
json.image_url url_for(topic.image) if topic.image.attached?
