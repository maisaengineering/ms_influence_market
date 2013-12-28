task :change_current_price => :environment do
  items = Item.all 
  items.each do | item |
  	previous_price = item.current_price
  	if item.update_attributes(current_price: rand(3..50))
  		front_window = Item.select("group_concat(id) as front_window").where("current_price > #{item.current_price}").first.front_window
  		rear_window = Item.select("group_concat(id) as rear_window").where("current_price < #{item.current_price}").first.rear_window
  		ItemPrice.create(item_id: item.id, price: previous_price, date: Time.now.to_date, front_window_item_ids: front_window, rear_window_item_ids: rear_window)
  	end
  end
end