class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.integer :patient_id
      t.datetime :start
      t.datetime :end
      t.integer :doctor_id

      t.timestamps
    end
  end
end
