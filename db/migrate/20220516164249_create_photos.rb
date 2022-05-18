class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :title

      t.timestamps
    end
  end
end
