json.array!(@comments) do |comment|
  json.extract! comment, :comment, :user_id, :place_id, :comment_title
  json.url comment_url(comment, format: :json)
end
