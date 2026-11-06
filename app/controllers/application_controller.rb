class ApplicationController < ActionController::Base
  include Authentication
  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale].presence_in(I18n.available_locales.map(&:to_s))||
    I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
