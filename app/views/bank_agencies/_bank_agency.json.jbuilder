json.extract! bank_agency, :id, :number, :zip, :street, :city, :state, :country, :created_at, :updated_at
json.url bank_agency_url(bank_agency, format: :json)
