json.extract! transaction, :id, :bank_account_id, :amount, :transaction_type, :user_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
