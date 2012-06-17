class CreateSpecializations < ActiveRecord::Migration
  def change
    create_table :specializations do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
    add_column :doctors, :specialization_id, :integer
  end
end
