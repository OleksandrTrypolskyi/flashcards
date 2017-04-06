class CorrectAssociations < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :deck_id, :integer
    remove_column :decks, :card_id
  end
end
