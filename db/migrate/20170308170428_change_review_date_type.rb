class ChangeReviewDateType < ActiveRecord::Migration[5.0]
  def change
    change_column :cards, :review_date, :date
  end
end
