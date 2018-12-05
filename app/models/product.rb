class Product < ApplicationRecord
  has_many :order_items

  # validates :price, numericality: { only_integer: true }, length: { maximum: 7 }
  validates :name, presence: true

  # Add a scope that checks if the active flag is set to true, so invalid/deleted products are not shown.
  default_scope {where(active: true)}

end
