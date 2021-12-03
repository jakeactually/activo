json.extract! user, :id, :code, :first_name, :last_name, :address, :company, :email, :phone, :position, :website, :role, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
