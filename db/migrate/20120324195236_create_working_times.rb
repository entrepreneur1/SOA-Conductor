class CreateWorkingTimes < ActiveRecord::Migration
  def change
    create_table :working_times do |t|
      t.integer :doctor_id
      t.time :start
      t.time :end
      t.integer :day

      t.timestamps
    end
  end
end
