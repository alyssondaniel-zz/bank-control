class CreateBankAgencies < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_agencies do |t|
      t.string :number
      t.string :zip
      t.string :street
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
