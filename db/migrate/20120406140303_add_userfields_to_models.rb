class AddUserfieldsToModels < ActiveRecord::Migration
  def change
    change_table :doctors do |t|
      t.references :user
    end
    change_table :patients do |t|
      t.references :user
    end
  end
end
