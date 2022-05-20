class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :user, foreign_key: true
      t.string :name, null: false
      t.string :title, null: false

      t.timestamps
    end
  end
end
