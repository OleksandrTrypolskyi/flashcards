# File for NotificationsMailer
class NotificationsMailer < ApplicationMailer
  default from: 'notifications@flashcards.com'

  def pending_cards(user)
    if user.email
      mail to: user.email, subject: 'Time to repeat Cards.'
    end
  end
end
