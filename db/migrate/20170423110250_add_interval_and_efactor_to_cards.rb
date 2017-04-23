class AddIntervalAndEfactorToCards < ActiveRecord::Migration[5.0]
  def change
    add_column :cards, :interval, :integer
    add_column :cards, :e_factor, :float, default: 2.5
  end
end
