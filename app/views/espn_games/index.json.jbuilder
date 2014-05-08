json.array!(@espn_games) do |espn_game|
  json.extract! espn_game, :id
  json.url espn_game_url(espn_game, format: :json)
end
