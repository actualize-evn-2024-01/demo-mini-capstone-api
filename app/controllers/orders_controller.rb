class OrdersController < ApplicationController
  before_action :authenticate_user

  def index
    # @orders = Order.where(id: current_user.id)
    @orders = current_user.orders
    render :index
  end

  def create
    carted_products = current_user.carted_products.where(status: "carted")
    calculated_subtotal = 0
    calculated_tax = 0
    carted_products.each do |carted_product|
      calculated_subtotal += carted_product.quantity * carted_product.product.price
      calculated_tax += carted_product.quantity * carted_product.product.tax
    end
    calculated_total = calculated_subtotal + calculated_tax

    @order = Order.create(
      user_id: current_user.id,
      subtotal: calculated_subtotal,
      tax: calculated_tax,
      total: calculated_total,
    )

    carted_products.each do |carted_product|
      carted_product.update(status: "purchased", order_id: @order.id)
    end

    render :show
  end

  def show
    # @order = Order.find_by(id: params[:id], user_id: current_user.id)
    @order = current_user.orders.find_by(id: params[:id])
    render :show
  end
end
