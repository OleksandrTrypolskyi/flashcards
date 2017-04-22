# File for ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    unless current_user
      flash[:warning] = "#{t('Please login or register')}"
      redirect_to login_path
    else
      current_user
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

  before_action :set_locale

  def set_locale
    if current_user
      set_locale_from_user_data
    elsif params[:locale]
      set_locale_from_params
    else
      set_locale_from_browser
    end
  end

  private

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  def set_locale_from_user_data
    I18n.locale = current_user.current_language
    logger.debug "* Locale set to '#{I18n.locale}' from language of current_user"
  end

  def set_locale_from_params
    I18n.locale = params[:locale]
    logger.debug "* Locale set to '#{I18n.locale}' from params"
  end

  def set_locale_from_browser
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}' from browser"
  end
end
