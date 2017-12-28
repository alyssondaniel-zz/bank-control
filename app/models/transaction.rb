class Transaction < ApplicationRecord
  belongs_to :bank_account
  belongs_to :transfer_from_bank_account, foreign_key: :tranfer_from_account_id, class_name: "BankAccount", optional: true
  belongs_to :transfer_to_bank_account, foreign_key: :tranfer_to_account_id, class_name: "BankAccount", optional: true
  belongs_to :user

  enum transaction_type: [ :credit, :debit, :transfer ]
  validates :amount, :transaction_type, presence: true
  validates :amount, numericality: { other_than: 0 }
  validate :exceeded_limit, if: :is_credit?
  validate :small_limit, if: :is_debit?

  after_create :update_balance

  def chargeback
    unless Transaction.where(chargeback_id: self.id).exists?
      chargeback = Transaction.new
      chargeback.amount = self.amount
      chargeback.user = self.user
      chargeback.bank_account = self.bank_account
      chargeback.chargeback_id = self.id

      if self.credit?
        chargeback.transaction_type = "debit"
      elsif self.debit?
        chargeback.transaction_type = "credit"
      end

      chargeback.save
    end
  end

  def transfer_to(bank_account_id)
    if bank_account_id
      destination = Transaction.new
      destination.bank_account_id = bank_account_id
      destination.user_id = self.user_id
      destination.transaction_type = "credit"
      destination.tranfer_from_account_id = self.bank_account_id
      destination.amount = self.amount

      destination.save ? self.update(tranfer_to_account_id: destination.bank_account_id) : self.chargeback
    else
      self.chargeback
    end
  end

  private
  def update_balance
    balance = self.bank_account.balance || 0.0
    if self.transaction_type == "credit"
      balance += self.amount
    elsif self.transaction_type == "debit"
      balance -= self.amount
    end
    self.bank_account.update(balance: balance)
  end

  def is_credit?
    self.transaction_type == "credit"
  end

  def is_debit?
    self.transaction_type == "debit"
  end

  def exceeded_limit
    if (self.amount || 0) > self.bank_account.limit
      errors.add(:amount, "can not exceed the Account limit: #{self.bank_account.limit}")
    end
  end

  def small_limit
    if (self.amount || 0) > self.bank_account.balance
      errors.add(:amount, "balance small: #{self.bank_account.balance}")
    end
  end
end
