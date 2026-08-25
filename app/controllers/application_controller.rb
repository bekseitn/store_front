# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order, :current_store_setting

  # Memoized per request, not cached across requests - this is a tiny
  # table (one row) and the rest of the app doesn't use a cache store
  # either, so adding one just for this would be inconsistent.
  def current_store_setting
    @current_store_setting ||= StoreSetting.current
  end

  def current_order
    # find_by, not find: session[:order_id] can outlive the Order it
    # points to (deleted via /admin, a cleanup task, or - all session
    # long - test data churn on this app's shared dev/test database).
    # A stale cookie shouldn't 500 every request; it should just read
    # as an empty cart again, same as no session at all.
    (session[:order_id].present? && Order.find_by(id: session[:order_id])) || Order.new
  end
end
