class CreateEventRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :event_requests do |t|
      t.references :user, foreign_key: true
      t.references :club, foreign_key: true
      t.string :name
      t.text :description
      t.integer :expense, default: 0
      t.date :date_start
      t.string :duration
      t.string :location
      t.boolean :approve, default: false

      t.timestamps
    end
  end
end
