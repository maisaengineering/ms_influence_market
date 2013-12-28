class ResearchsController < ApplicationController

#Action to provide details on items 
  def index
  	@your_activity = Trade.limit(5) #The will be as per user
  	@top_ten_items = Trade.select("price,tarde_type,item_id, count(*) as count ").group("item_id").order("count desc")
  	@top_ten_trending_items = Trade.select("price,tarde_type,item_id, count(*) as count ").where("date > timestampadd(day, -1, now())").group("item_id").order("count desc")
  	highest_price_both = Item.joins(:item_prices).select("items.id, abs(items.current_price - item_prices.price) as diff").where("date > timestampadd(day, -1, now())").order("diff desc").limit(5).collect { |data| data.id }
  	
      @highest_price_both = Trade.where(["item_id in (?) AND date > timestampadd(day, -1, now())",highest_price_both.uniq! ]).group(:item_id)
  	item = @your_activity.last
  	window = ItemPrice.where("item_id = #{item.item_id} AND date > timestampadd(day, -1, now())").last
  	@rear_window = Item.where("id IN (#{window.rear_window_item_ids})").order("current_price desc").limit(5)
  	@front_window = Item.where("id IN (#{window.front_window_item_ids})").order("current_price desc").limit(5)
      @highest_volume = Trade.select("price, MAX(price) * count(*) as volume,tarde_type,item_id, count(*) as count ").group("item_id").order("volume desc")
  end
end