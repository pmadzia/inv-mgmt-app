class ApplicationController < ActionController::Base
  include Authentication
  around_action :switch_locale
  before_action :set_theme
  helper_method :get_current_theme

  def switch_locale(&action)
    available = I18n.available_locales.map(&:to_s)
    if params[:locale].in?(available)
        cookies.permanent[:locale] = params[:locale]
    end
    locale = cookies[:locale].presence_in(available) || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def set_theme
    if params[:theme].in?(%w[light dark])
      cookies.permanent[:theme] = params[:theme]
    end
  end

  def get_current_theme
      cookies[:theme] == "dark" ? "dark" : "light"
  end
end
