class AddIndexCards < ActiveRecord::Migration[5.0]
  def change
    add_index :cards, :user_id
  end
end
