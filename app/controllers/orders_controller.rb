class OrdersController < ApplicationController
  def index
    # @orders = Order.where(id: current_user.id)
    @orders = current_user.orders
    render :index
  end

  def create
    # Find the product from the Product model that has an id that matches params[:product_id]
    product = Product.find_by(id: params[:product_id])
    # Get the price of that product
    price = product.price
    # Calculate the subtotal by multiplying the price by the params[:quantity]
    calculated_subtotal = price * params[:quantity].to_i
    # Calculate the tax using 0.09 OR use the product's tax method
    calculated_tax = product.tax * params[:quantity].to_i
    # Calculate the total by adding the subtotal and tax
    calculated_total = calculated_subtotal + calculated_tax

    @order = Order.create(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total,
    )
    render :show
  end

  def show
    # @order = Order.find_by(id: params[:id], user_id: current_user.id)
    @order = current_user.orders.find_by(id: params[:id])
    render :show
  end
end
