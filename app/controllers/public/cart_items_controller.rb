class Public::CartItemsController < ApplicationController
  def index
   @cart_items = current_customer.cart_items.all
   @total = 0
  end

  def update

   cart_item = CartItem.find(params[:id])
   cart_item.update(cart_item_params)
   redirect_to cart_items_path
  end

  def destroy
   cart_item = CartItem.find(params[:id])
   cart_item.destroy
   redirect_to cart_items_path
  end

  def destroy_all
   # 全てのカート内商品
   @cart_items = CartItem.all
   # ログイン中のユーザーが、カート内商品を全て削除する
   current_customer.cart_items.destroy_all
   # 削除後、カート画面へリダイレクト
   redirect_to cart_items_path
  end

  def create
   @item = Item.find(cart_item_params[:item_id])
   @cart_item = current_customer.cart_items.new(cart_item_params)
   @cart_item.save
   redirect_to cart_items_path
  end

  # 小計を求めるメソッド
  def subtotal
   item.with_tax_price * amount
  end

  private

  def cart_item_params
   params.require(:cart_item).permit(:item_id, :amount)
  end

end
