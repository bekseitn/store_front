# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  # Intentionally unset until checkout (Ordering#set_order_items assigns
  # it later) - without `optional: true` here, Rails 5's
  # belongs_to_required_by_default would break "add to cart".
  belongs_to :ordering, optional: true

  validates :quantity, presence: true, numericality: {only_integer: true, greater_than: 0}
  validate :product_present
  validate :order_present

  before_save :finalize

  def unit_price
    persisted? ? self[:unit_price] : product.price
  end

  def total_price
    unit_price * quantity
  end

  def product_name
    # rails_admin uses this as OrderItem's object_label_method, and
    # (unlike the 0.7 line this app was on) calls it even for a brand
    # new, unsaved record on the admin "new" form - where product is
    # nil. Found by actually loading /admin/order_item/new.
    product&.name
  end

  private

  def product_present
    errors.add(:product, 'is not valid or is not active.') if product.nil?
  end

  def order_present
    errors.add(:order, 'is not a valid order.') if order.nil?
  end

  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end
end
