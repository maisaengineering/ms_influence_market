class ItemPrice < ActiveRecord::Base
	################ 
	## ASSOCIATIONS
	################
	 belongs_to :item

	################
	##Accessor
	################
	attr_accessible :date, :front_window_item_ids, :item_id, :price, :rear_window_item_ids
		
	################
	##CONSTANTS
	################
	
	
	################
	## VALIDATIONS
	################

	################
	##SCOPES
	################
	
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
