class UpdateCardModel < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :review_date, :datetime
    add_column :cards, :number_of_successfull_checks, :integer, default: 0
    add_column :cards, :number_of_wrong_checks, :integer, default: 0
  end
end
