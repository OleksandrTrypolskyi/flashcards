class Card < ApplicationRecord
  validates :original_text,   presence: true, format: { with: /\A[a-zA-Zа-яА-ЯёЁ_,();:"']+\z/,
    message: "Only letters can be used" }
  validates :translated_text, presence: true, format: { with: /\A[a-zA-Zа-яА-ЯёЁ_,();:"']+\z/,
    message: "Only letters can be used" }
  validates :review_date, format: { with: /\A[0-9]{4}-(0[1-9]|1[012])-(0[1-9]|1[0-9]|2[0-9]|3[01])\z/,
    message: "Incorrect date format" }
  validate :original_cannot_be_similar_to_translated

  def original_cannot_be_similar_to_translated
    if self.original_text.downcase == self.translated_text.downcase
      self.errors[:base] << 'Original text cannot be similar to the translated one.'
    end
  end

  before_create :update_review_date

  def update_review_date
    self.review_date = Date.today + 3.days
  end

  def update_review_date_after_check
    update(review_date: Date.today + 3.days)
  end

  scope :for_review, -> { where('review_date <= ?', Date.today) }

  def confirm_reviewing(original_verification)
    self.original_text == original_verification
  end

  belongs_to :user, inverse_of: :cards
end
