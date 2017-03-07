class CorrectColumnNames < ActiveRecord::Migration[5.0]
  def change
    rename_column :cards, :Original_text, :original_text
    rename_column :cards, :Translated_text, :translated_text
    rename_column :cards, :Review_date, :review_date
  end
end
