class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.integer :expense, default: 0
      t.references :club, foreign_key: true
      t.date :date_start
      t.string :duration
      t.string :image
      t.string :location
      t.integer :number_like, default: 0
      t.timestamps
    end
  end
end
