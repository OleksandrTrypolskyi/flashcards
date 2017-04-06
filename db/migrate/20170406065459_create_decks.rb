class CreateDecks < ActiveRecord::Migration[5.0]
  def change
    create_table :decks do |t|
      t.string :name
      t.belongs_to :card, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
