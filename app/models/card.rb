class Card < ApplicationRecord
  validates :original_text,   presence: true, format: { with: /\A[a-zA-Zа-яА-ЯёЁ_,();:"']+\z/,
                                                        message: 'Only letters can be used' }
  validates :translated_text, presence: true, format: { with: /\A[a-zA-Zа-яА-ЯёЁ_,();:"']+\z/,
                                                        message: 'Only letters can be used' }
  validate :original_cannot_be_similar_to_translated

  def original_cannot_be_similar_to_translated
    if self.original_text.downcase == self.translated_text.downcase
      self.errors[:base] << 'Original text cannot be similar to the translated one.'
    end
  end

  before_create :update_review_date

  def update_review_date
    self.review_date = Time.now
  end

  def update_review_date_after_correct_check
    number_of_wrong_checks = 0
    update_review_date
    if number_of_successfull_checks > 4
      self.number_of_successfull_checks += 1
      self.review_date += 30.days
    end
    case number_of_successfull_checks
    when 0
      self.number_of_successfull_checks += 1
      self.review_date += 0.5.days
    when 1
      self.number_of_successfull_checks += 1
      self.review_date += 3.days
    when 2
      self.number_of_successfull_checks += 1
      self.review_date += 7.days
    when 3
      self.number_of_successfull_checks += 1
      self.review_date += 14.days
    when 4
      self.number_of_successfull_checks += 1
      self.review_date += 30.days
    end
    save
  end

  def update_review_date_after_wrong_check
    case number_of_wrong_checks
    when 0
      self.number_of_wrong_checks += 1
    when 1
      self.number_of_wrong_checks += 1
    when 2
      self.number_of_wrong_checks += 1
    when 3
      update_review_date
      self.number_of_wrong_checks = 0
      self.number_of_successfull_checks = 0
    end
  end

  scope :for_review, -> { where('review_date <= ?', Time.now) }

  def confirm_reviewing(original_verification)
    self.original_text == original_verification
  end

  belongs_to :user
  belongs_to :deck

  has_attached_file :picture, styles: { original: '360x360>'}
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

end
