class CreateFacilities < ActiveRecord::Migration[8.0]
  def change
    create_table :facilities do |t|
      t.references :ward, null: false, foreign_key: true
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
