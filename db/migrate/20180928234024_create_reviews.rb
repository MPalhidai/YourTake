class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.reference :user
      t.reference :movie

      t.timestamps
    end
  end
end