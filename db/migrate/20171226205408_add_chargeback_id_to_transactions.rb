class AddChargebackIdToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :chargeback_id, :integer
  end
end
