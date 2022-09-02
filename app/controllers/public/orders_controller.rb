class Public::OrdersController < ApplicationController
  def new
  end

  def index
   @orders = Order.all
  end

  def show
  end

  def create
  end

  def confirm
  end

  def complete
  end

end
