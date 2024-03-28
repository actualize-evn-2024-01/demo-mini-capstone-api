class Category < ApplicationRecord
  has_many :category_products

  # def products
  #   result = []
  #   index = 0
  #   while index < category_products.length
  #     category_product = category_products[index]
  #     product = category_product.product
  #     result << product
  #     index = index + 1
  #   end
  #   result
  # end
  has_many :products, through: :category_products
end
