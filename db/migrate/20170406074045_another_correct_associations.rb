class AnotherCorrectAssociations < ActiveRecord::Migration[5.0]
  def change
    add_column :decks, :card_id, :integer
    remove_column :cards, :deck_id
    remove_column :cards, :user_id
  end
end
