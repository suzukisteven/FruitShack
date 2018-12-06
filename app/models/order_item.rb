class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  # Validations ensure that quantity is a number(integer) and is greater than 0
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  # Also check if product is present and valid.
  validate :product_present
  validate :order_present

  before_save :finalize

  # If order item is persisted, return the content of the unit_price field instead.
  # Else, take associated product's price if the order item is not currently persisted (i.e. it's new)
  def unit_price
    if persisted?
      self[:unit_price]
    else
      product.price
    end
  end

  def total_price
    unit_price * quantity
  end

  private

  def product_present
    if product.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  # Before the model is saved, the value of unit_price is saved to the unit_price field
  # so that if (for some reason) the price of the product is changed, the user will still be available
  # to buy the product at the original price.

  # Updates the unit_price and total_price fields with the proper values.
  def finalize
    self[:unit_price] = unit_price
    self[:total_price] = quantity * self[:unit_price]
  end

end
