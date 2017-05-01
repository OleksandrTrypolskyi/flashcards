require 'rails_helper'

RSpec.feature 'Login checking', type: :feature do
  let!(:user) { create :user }

  before(:each) do
    page.driver.header('Accept-Language', 'en')
  end

  describe 'Loggin process' do
    it 'login successful' do
      login_user
    end
  end
end
