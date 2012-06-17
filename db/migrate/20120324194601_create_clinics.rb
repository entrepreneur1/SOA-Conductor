class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.integer :address_id

      t.timestamps
    end
  end
end
