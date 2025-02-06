class CreateCheckinLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :checkin_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :facility, null: false, foreign_key: true

      t.timestamps
    end
  end
end
