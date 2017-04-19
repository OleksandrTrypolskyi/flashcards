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

  before_create :set_review_date

  def set_review_date
    self.review_date = Time.now
  end

  def update_review_date_after_correct_check
    time = Time.now
    schedule = [time + 0.5.days, time + 3.days, time + 7.days,
                 time + 14.days, time + 30.days]
    number_of_wrong_checks = 0
    self.review_date = if number_of_successfull_checks > 4
       schedule[4]
    else
       schedule.at(self.number_of_successfull_checks)
    end
    self.number_of_successfull_checks += 1
  end

  def update_review_date_after_wrong_check
    if number_of_wrong_checks == 3
      set_review_date
      self.number_of_wrong_checks = 0
      self.number_of_successfull_checks = 0
    else
      self.number_of_wrong_checks += 1
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
