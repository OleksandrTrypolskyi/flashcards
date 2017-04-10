class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name
      t.belongs_to :user, index: true
      t.timestamps
    end
    add_column :cards, :deck_id, :integer
    add_column :users, :current_deck_id, :integer
    add_attachment :cards, :picture
    #add_index :cards, :user_id
  end
end
