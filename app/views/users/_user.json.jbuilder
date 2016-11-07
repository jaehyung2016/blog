json.extract! user, :id, :email, :password_digest, :first_name, :last_name, :is_admin, :created_at, :updated_at
json.url user_url(user, format: :json)