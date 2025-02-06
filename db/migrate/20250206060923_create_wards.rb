class CreateWards < ActiveRecord::Migration[8.0]
  def change
    create_table :wards do |t|
      t.string :name
      t.string :name_kana

      t.timestamps
    end
  end
end
