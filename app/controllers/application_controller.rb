# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_order

  def current_order
    session[:order_id].present? ? Order.find(session[:order_id]) : Order.new
  end
end
