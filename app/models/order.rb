class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_items

  before_validation :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect {|oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0}.sum
  end

  def shipping
    5
  end

  def tax
    (subtotal * 1.06) - subtotal
  end

  def total
    subtotal + tax + shipping
  end

  # Called during checkout - Resets the cart by setting order_status_id to 4: i.e. Cart status is 'completed'.
  # Also updates subtotal to 0 and removes all order_items
  def clear_cart
    self.order_status_id = 4
    self[:subtotal] = 0
    self.order_items.destroy_all
  end

  private

  # Called during create - sets order_status_id to 1: i.e. Cart status is 'in progress'.
  def set_order_status
    self.order_status_id = 1
  end

  # Called during save - sums up order item's total cost and stores it in subtotal field.
  def update_subtotal
    self[:subtotal] = subtotal
  end

end
