json.targets @targets.each do |target|
  json.target do
    json.partial! 'api/v1/targets/info', target: target
  end
end
