class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.integer :external_id
      t.references :user
      t.references :movie

      t.timestamps
    end
  end
end
