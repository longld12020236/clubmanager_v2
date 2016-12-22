class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string :name
      t.references :album, foreign_key: true
      t.references :user, foreign_key: true
      t.string :url
      t.timestamps
    end
  end
end
