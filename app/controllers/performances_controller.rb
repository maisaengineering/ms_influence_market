class PerformancesController < ApplicationController
  
  #Get the Performance Report of your purchase and sales
  def index
  	@trade_items = Trade.limit(5)
  end
end
