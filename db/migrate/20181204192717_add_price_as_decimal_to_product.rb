class AddPriceAsDecimalToProduct < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :price, :integer
    
    add_column :products, :price, :decimal, precision: 12, scale: 3
    add_column :products, :active, :boolean
  end
end
