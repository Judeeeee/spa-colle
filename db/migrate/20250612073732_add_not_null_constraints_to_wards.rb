class AddNotNullConstraintsToWards < ActiveRecord::Migration[8.0]
  def change
    change_column_null :wards, :name, false
    change_column_null :wards, :name_kana, false
  end
end
