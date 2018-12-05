class Order < ApplicationRecord
  belongs_to :order_status
  has_many :order_items

  before_validation :set_order_status
  before_save :update_subtotal

  def subtotal
    order_items.collect {|oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0}.sum
  end

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
