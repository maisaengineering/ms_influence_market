class TradesController < ApplicationController
  
  #Trade a new item
  def index
  	@trade = Trade.new
  end

  #Creating a tarde for new item
  def create
  	@trade = Trade.new(params[:trade])
  	if @trade.save
  		redirect_to trades_path, flash: { notice: "Your order has been received"}
  	else
		redirect_to trades_path, flash: { alert: "Sorry, your order has been declined."}
  	end
  end

  #Ajax to get current price of any item
  def get_current_price
  	@item = Item.find(params[:id])
  	render :layout => false
  end
end
