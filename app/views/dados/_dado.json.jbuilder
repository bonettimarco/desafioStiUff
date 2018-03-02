json.extract! dado, :id, :nome, :telefone, :email, :uffmail, :status, :created_at, :updated_at
json.url dado_url(dado, format: :json)
