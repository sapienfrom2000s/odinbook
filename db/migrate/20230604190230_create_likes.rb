class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.timestamps
    end
    add_reference :likes, :user, foreign_key: { to_table: :users }
    add_reference :likes, :post, null: false, foreign_key: { to_table: :posts }
  end
end
