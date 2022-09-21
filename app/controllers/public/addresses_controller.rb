class Public::AddressesController < ApplicationController
  def index
   # Viewのform_withへ渡すための「空のモデル」を生成する
   @address = Address.new
   # 全ての配送先データを取得する
   @addresses = Address.all
  end

  def edit
   # データレコードを１件取得
   @address = Address.find(params[:id])
  end

  def create
   # データを受け取り新規登録するためのインスタンス作成
   @address = Address.new(address_params)
   # データをデータベースに保存する
   @address.save
   # 配送先新規登録後、配送先登録／一覧にリダイレクト
   redirect_to addresses_path
  end

  def update
   # データレコードを１件取得
   @address = Address.find(params[:id])
   # 変更を保存する
   @address.update(address_params)
   # 保存後、配送先登録／一覧にリダイレクト
   redirect_to addresses_path
  end

  def destroy
   # データレコードを１件取得
   @address = Address.find(params[:id])
   # データレコードを削除
   @address.destroy
   # 配送先新規登録後、配送先登録／一覧にリダイレクト
   redirect_to addresses_path
  end

  private
  # 配送先データのストロングパラメータ
  def address_params
   params.require(:address).permit(:postal_code, :address, :name)
  end

end
