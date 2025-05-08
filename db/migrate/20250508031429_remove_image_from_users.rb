class RemoveImageFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :image, :string
  end
end
