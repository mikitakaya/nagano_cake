class Public::CartItemsController < ApplicationController
  def index
   # ログインカスタマーのカート内商品データを全て取得する
   @cart_items = current_customer.cart_items.all
   @total = 0
  end

  def update
   # 登録済みのデータを取得する
   cart_item = CartItem.find(params[:id])
   # カート内商品情報を個別で更新する
   cart_item.update(cart_item_params)
   # 更新後、カート内商品一覧画面にリダイレクト
   redirect_to cart_items_path
  end

  def destroy
   # 登録済みのデータを取得する
   cart_item = CartItem.find(params[:id])
   # カート内商品情報を個別で削除する
   cart_item.destroy
   # 削除後、カート内商品一覧画面にリダイレクト
   redirect_to cart_items_path
  end

  def destroy_all
   # 全てのカート内商品
   @cart_items = CartItem.all
   # ログイン中のユーザーが、カート内商品を全て削除する
   current_customer.cart_items.destroy_all
   # 削除後、カート内商品一覧画面にリダイレクト
   redirect_to cart_items_path
  end

  def create
   # 登録済みのデータを取得する
   @item = Item.find(cart_item_params[:item_id])
   # カートに新規レコードを作成する
   @cart_item = current_customer.cart_items.new(cart_item_params)
   # カート内商品／顧客ID ＝　ログイン中のカスタマー
   @cart_item.customer_id = current_customer.id
   # ログイン中のカスタマーの全てのカート内商品を意味する
   @cart_items = current_customer.cart_items.all

   # カートの中身を一個ずつ取り出す
   @cart_items.each do |cart_item|
    # カート内商品ID ＝　新規追加商品IDだった場合
    if cart_item.item_id == @cart_item.item_id
     # カート内商品の数量＋新規追加商品の数量を合算し、new_amountに代入
     new_amount = cart_item.amount + @cart_item.amount
     # cart_itemモデルのamountをnew_amountに更新する
     cart_item.update_attribute(:amount, new_amount)
     # 重複商品は削除する
     @cart_item.delete
    # 上記に当てはまらない場合
    else
     # 新規レコードを保存する
     @cart_item.save
    end
   end
   # 全ての処理が終了したのち、カート内商品一覧画面にリダイレクト
   redirect_to cart_items_path
  end

  # 小計を求めるメソッド
  def subtotal
   item.with_tax_price * amount
  end

  private
  # カート内データのストロングパラメータ
  def cart_item_params
   params.require(:cart_item).permit(:item_id, :amount)
  end

end
