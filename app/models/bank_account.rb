class BankAccount < ApplicationRecord
  belongs_to :bank_agency
  belongs_to :user
  has_many :transactions

  validates :number, uniqueness: true
  validates :bank_agency_id, :user_id, :number, :limit, presence: true

  after_commit :set_default_bank_account_id

  private
  def set_default_bank_account_id
    self.user.update(current_bank_account_id: self.id) unless self.user.current_bank_account_id
  end
end
