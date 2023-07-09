class CreateNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :notifications do |t|
      t.text :details

      t.timestamps
    end
    add_reference(:notifications, :user, foreign_key: { to_table: :users })
  end
end
