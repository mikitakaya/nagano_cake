class Public::HomesController < ApplicationController
  def top
    @items = Item.all.limit(4).order("created_at DESC")
  end

  def about
  end

end
