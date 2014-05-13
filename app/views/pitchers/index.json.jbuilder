json.array!(@pitchers) do |pitcher|
  json.extract! pitcher, :id
  json.url pitcher_url(pitcher, format: :json)
end
