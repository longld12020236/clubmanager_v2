class CreateNews < ActiveRecord::Migration[5.0]
  def change
    create_table :news do |t|
      t.string :title
      t.text :content
      t.string :image
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :approve, default: false
      t.timestamps
    end
  end
end
