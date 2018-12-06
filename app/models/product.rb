class Product < ApplicationRecord
  has_many :order_items

  validates :name, presence: true
  validates :price, numericality: { only_integer: true, greater_than: 0 }, length: { maximum: 7 }

  mount_uploader :image, ProductimgUploader
  
  # Add a scope that checks if the active flag is set to true, so invalid/deleted products are not shown.
  default_scope { where(active: true) }
  scope :multi, -> (values) { where("name iLike ? OR description iLike ?", "%#{values}%", "%#{values}%") }

end
