class Admin::ItemsController < ApplicationController
  def index
  end

  def new
   # Viewのform_withへ渡すための「空のモデル」を生成する
   @item = Item.new
   @genres = Genre.all
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

end
