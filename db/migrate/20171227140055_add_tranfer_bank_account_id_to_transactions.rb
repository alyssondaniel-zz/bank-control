class AddTranferBankAccountIdToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :tranfer_from_account_id, :integer
    add_column :transactions, :tranfer_to_account_id, :integer
  end
end
