class CreateDoctors < ActiveRecord::Migration
  def change
    create_table :doctors do |t|
      t.string :name
      t.string :surname
      t.integer :clinic_id
      t.integer :visit_duration

      t.timestamps
    end
  end
end
