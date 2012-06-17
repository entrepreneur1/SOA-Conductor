class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :doctor_id
      t.string :comment
      t.integer :rate

      t.timestamps
    end
  end
end
