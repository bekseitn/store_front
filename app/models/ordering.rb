class Ordering < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :order
  belongs_to :city
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
    order.order_items.update_all(ordering_id: id, order_id: nil)
  end

  def set_order_status
    self.order_status_id = 1
  end

  def set_total
    self.total = order.total
  end

end
