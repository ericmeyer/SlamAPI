json.key_format! camelize: :lower
json.array! @matches do |match|
  json.player_one match.player_one
  json.player_two match.player_two
  json.id match.id
end
