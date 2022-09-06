class Admin::GenresController < ApplicationController
  def index
  end

  def create
   # Viewのform_withへ渡すための「空のモデル」を生成する。
   @newgenre = Genre.new
   # データを受け取り新規登録するためのインスタンス作成
   @genre = Genre.new(genre_params)
   # データをデータベースに保存する
   @genre.save
   # ジャンル登録後、ジャンル一覧画面にリダイレクト
   redirect_to admin_genres_path
  end

  def edit
  end

  def update
  end

end
