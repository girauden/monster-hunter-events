class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  around_action :set_time_zone
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_url, alert: 'You do not have access to this page'
  end

protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email])
  end

  def set_time_zone
    return yield unless (utc_offset = cookies['browser.tzoffset']).present?
    utc_offset = utc_offset.to_i
    gmt_offset = if utc_offset == 0 then nil elsif utc_offset > 0 then -utc_offset else "+#{-utc_offset}" end
    Time.use_zone("Etc/GMT#{gmt_offset}") { yield }
  rescue ArgumentError
    yield
  end

end
