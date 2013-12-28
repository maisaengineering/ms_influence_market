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
    def search(params)
      if params[:item_id].present? and params[:item_name].present?
        where('id =? OR name LIKE ?' , params[:item_id],"%#{params[:item_name]}%")
      elsif params[:item_id].present?
        where(id: params[:item_id])
      elsif params[:item_name].present?
        where('name LIKE ?' , "%#{params[:item_name]}%" )
      else
        scoped
      end
    end
	end
	################
	##PUBLIC METHODS
	################ 
end
