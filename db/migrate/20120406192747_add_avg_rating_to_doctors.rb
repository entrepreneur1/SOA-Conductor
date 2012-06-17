class AddAvgRatingToDoctors < ActiveRecord::Migration
  def change
    add_column :doctors, :avg_rating, :float

  end
end
