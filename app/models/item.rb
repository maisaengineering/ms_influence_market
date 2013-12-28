class Item < ActiveRecord::Base

	################ 
	## ASSOCIATIONS
	################

	has_many :trades
  	has_many :item_prices

	################
	##Accessor
	################
	attr_accessible :current_price, :name
	
	################
	##CONSTANTS
	################
	
	
	################
	## VALIDATIONS
	################

	################
	##SCOPES
	################
	scope :bought_items, self.joins(:trades).where("tarde_type = 'buy'")
  	scope :sold_items, self.joins(:trades).where("tarde_type = 'sell'")

	################
	##CALLBACKS
	################
	
	################
	##CLASS METHODS
	################
	
	class << self
	end
	################
	##PUBLIC METHODS
	################ 
end
