class Product < ApplicationRecord
  def is_discounted?
    result = true
    if price <= 10
      result = true
    else
      result = false
    end
    result
  end

  def tax
    result = price * 0.09
    result
  end

  def total
    result = price * 1.09
    result
  end
end
