require 'rails_helper'

RSpec.feature 'Login checking', type: :feature do
  let!(:user) { create :user }

  describe 'Loggin process' do
    it 'login successful' do
      login_user
    end
  end
end
