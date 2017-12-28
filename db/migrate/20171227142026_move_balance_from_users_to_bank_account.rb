class MoveBalanceFromUsersToBankAccount < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :balance
    add_column :bank_accounts, :balance, :float, default: 0
  end

  def down
    remove_column :bank_accounts, :balance
    add_column :users, :balance, :float, default: 0
  end
end
