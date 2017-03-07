class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.column :Original_text,   :string
      t.column :Translated_text, :string
      t.column :Review_date,     :datetime

      t.column :created_at,      :datetime
      t.column :updated_at,      :datetime
    end
  end
end
