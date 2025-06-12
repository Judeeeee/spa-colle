class AddNotNullConstraintsToFacilities < ActiveRecord::Migration[8.0]
  def change
    change_column_null :facilities, :name, false
    change_column_null :facilities, :latitude, false
    change_column_null :facilities, :longitude, false
  end
end
