json.array!(@previews_rules) do |previews_rule|
  json.extract! previews_rule, :id
  json.url previews_rule_url(previews_rule, format: :json)
end
