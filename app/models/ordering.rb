# frozen_string_literal: true

class Ordering < ApplicationRecord
  belongs_to :order_status
  belongs_to :order
  # optional: true because we handle its presence explicitly below - the
  # implicit belongs_to_required_by_default check produces an untranslated
  # "Translation missing" (:required i18n key has no Russian message here,
  # unlike :blank) instead of a real error, found by actually triggering
  # this validation in a browser. Both checks firing at once (before this
  # was added) also just duplicated the "can't be blank" message.
  belongs_to :city, optional: true
  has_many :order_items, dependent: :destroy
  # order_status_id has to be set before validation runs, not just
  # before_create: belongs_to_required_by_default (Rails 5+) added an
  # implicit presence check on order_status, and validation happens
  # before before_create callbacks. Under Rails 4.2 this ran unnoticed
  # (no such validation existed yet) - found by actually running the
  # checkout flow against Rails 7.2.
  before_validation :set_order_status
  before_create :set_total
  after_create :set_order_items

  validates :city, :name, :address, :phone, presence: true

  private

  def set_order_items
    # rubocop:disable Rails/SkipsModelValidations -- deliberate: this is
    # a bulk reassignment of already-valid, already-persisted items
    # (see CLAUDE.md's cart/checkout section), not new data that needs
    # validating.
    order.order_items.update_all(ordering_id: id, order_id: nil)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def set_order_status
    self.order_status_id = 1
  end

  def set_total
    self.total = order.total
  end
end
