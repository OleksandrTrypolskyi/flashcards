require "rails_helper"

RSpec.describe NotificationsMailer, type: :mailer do
  describe 'pending_cards' do
    let!(:user) { create :user }
    let!(:mail) { described_class.pending_cards(user).deliver_now }
    it 'renders the headers' do
      expect(mail.subject).to eq('Time to repeat Cards.')
      expect(mail.to[0]).to eq(user.email)
      expect(mail.from).to eq(['notifications@flashcards.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match("It's time to repeat your cards.")
    end

  end
end
