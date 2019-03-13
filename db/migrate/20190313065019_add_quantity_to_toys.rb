class AddQuantityToToys < ActiveRecord::Migration[5.2]
  def change
    add_column :toys, :quantity, :integer, default: 0
  end
end
