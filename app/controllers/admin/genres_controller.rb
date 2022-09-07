class Admin::GenresController < ApplicationController
  def index
   # Viewのform_withへ渡すための「空のモデル」を生成する
   @genre = Genre.new
   # 全てのジャンルデータを取得する
   @genres = Genre.all
  end

  def create
   # データを受け取り新規登録するためのインスタンス作成
   @genre = Genre.new(genre_params)
   # データをデータベースに保存する
   @genre.save
   # ジャンル登録後、ジャンル一覧画面にリダイレクト
   redirect_to admin_genres_path
  end

  def edit
   # 登録済みのデータを取得する
   @genre = Genre.find(params[:id])
  end

  def update
   # 登録済みのデータを取得する
   @genre = Genre.find(params[:id])
   # ジャンルの更新が成功した場合
   if @genre.update(genre_params)
    # ジャンル一覧画面にリダイレクト
    redirect_to admin_genres_path
   else
    # falseの場合、編集画面を再表示する
    render :edit
   end
  end

  # ジャンルデータのストロングパラメータ
  private

  def genre_params
   params.require(:genre).permit(:name)
  end

end
