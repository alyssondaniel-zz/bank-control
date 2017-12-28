class AddCurrentBankAccountMainIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_bank_account_id, :integer
  end
end
