class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :number
      t.string :postcode
      t.integer :clinic_id

      t.timestamps
    end
  end
end
