# File for Card model
class Card < ApplicationRecord
  validates :original_text,   presence: true,
            format: { with: /\A[a-zA-Zа-яА-ЯёЁ_,();:"']+\z/ }
  validates :translated_text, presence: true,
            format: { with: /\A[a-zA-Zа-яА-ЯёЁ_,();:"']+\z/ }
  validate  :original_cannot_be_similar_to_translated

  def original_cannot_be_similar_to_translated
    if original_text.downcase == translated_text.downcase
      errors[:base] << 'Original text cannot be similar to the translated one.'
    end
  end

  before_create :set_review_date

  def set_review_date
    self.review_date = Time.now
  end

  scope :for_review, -> { where('review_date <= ?', Time.now) }

  def confirm_check(original_verification)
    original_text == original_verification
  end

  # User can misprint, 5 mistakes are possible.
  def confirm_check_misprint(original_verification)
    DamerauLevenshtein.distance(original_text, original_verification) <= 5
  end

  belongs_to :user
  belongs_to :deck

  has_attached_file :picture, styles: { original: '360x360>' }
  validates_attachment_content_type :picture, content_type: %r{\Aimage\/.*\z}
end
