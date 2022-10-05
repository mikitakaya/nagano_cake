class Admin::ItemsController < ApplicationController
 before_action :authenticate_admin!

  def index
   # itemsテーブルに保存されている全てのデータを取得する
   @items = Item.page(params[:page])
  end

  def new
   # Viewのform_withへ渡すための「空のモデル」を生成する
   @item = Item.new
   # genresテーブルに保存されている全てのデータを取得する
   @genres = Genre.all
  end

  def create
   # データを受け取り新規登録するためのインスタンス作成
   @item = Item.new(item_params)
   # データをデータベースに保存する
   if @item.save
    # 商品詳細画面にリダイレクト
    redirect_to admin_item_path(@item.id)
   # 保存に失敗した場合
   else
    # 商品新規登録画面を再表示
    @genres = Genre.all
    render :new
   end
  end

  def show
   # レコードを1件だけ取得
   @item = Item.find(params[:id])
  end

  def edit
   # レコードを1件だけ取得
   @item = Item.find(params[:id])
   # genresテーブルに保存されている全てのデータを取得する
   @genres = Genre.all
  end

  def update
   # レコードを1件だけ取得
   @item = Item.find(params[:id])
   @item.update(item_params)
   # 商品詳細画面にリダイレクト
   redirect_to admin_item_path(@item.id)
  end

  private
  # 商品データのストロングパラメータ
  def item_params
   params.require(:item).permit(:image, :name, :introduction, :genre_id, :price, :is_active)
  end

end
