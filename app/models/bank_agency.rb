class BankAgency < ApplicationRecord
  has_many :bank_accounts

  validates :number, uniqueness: true
  validates :number, :zip, :street, :city, :state, :country, presence: true
end
