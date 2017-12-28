class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :bank_account, foreign_key: true
      t.float :amount
      t.integer :transaction_type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
