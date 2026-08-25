# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = Product.joins(:category).order(created_at: :desc)
    @products = @products.search_query(params[:search_query]) if params[:search_query].present?
    @products = @products.with_price_gte(params[:with_price_gte]) if params[:with_price_gte].present?
    @products = @products.with_price_lt(params[:with_price_lt]) if params[:with_price_lt].present?
    @products = @products.page(params[:page]).per_page(10)
    @order_item = current_order.order_items.new
  end
end
