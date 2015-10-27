json.array!(@users) do |user|
  json.extract! user, :id, :username, :email, :password, :firstname, :lastname, :bio, :major, :hometown, :age, :gender
  json.url user_url(user, format: :json)
end
