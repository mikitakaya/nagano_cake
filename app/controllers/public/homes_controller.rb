class Public::HomesController < ApplicationController
  before_action :authenticate_admin!, except: [:top, :about]

  def top
    # order("created_at DESC") = 一覧表示を最新から表示
    # limit(4) = 表示4件まで
    @items = Item.all.order("created_at DESC").limit(4)
  end

  def about
  end

end
