class CreateBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.integer :bank_agency_id
      t.string :number
      t.float :limit

      t.timestamps
    end
  end
end
