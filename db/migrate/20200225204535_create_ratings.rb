class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.integer :star, null: false
      t.references :post, foreign_key: true
      t.timestamps
    end
  end
end
