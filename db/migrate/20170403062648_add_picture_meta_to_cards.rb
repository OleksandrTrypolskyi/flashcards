class AddPictureMetaToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :picture_meta, :text
  end
end
