class AddUserIdToBankAccounts < ActiveRecord::Migration[5.1]
  def change
    add_column :bank_accounts, :user_id, :integer
  end
end
