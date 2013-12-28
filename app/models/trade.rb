class Trade < ActiveRecord::Base
    ################ 
    ## ASSOCIATIONS
    ################
    belongs_to :item

    ################
    ##Accessor
    ################
    attr_accessible :date, :item_id, :order_type, :price, :tarde_type
    
    ################
    ##CONSTANTS
    ################
    
    
    ################
    ## VALIDATIONS
    ################
    validates :price, presence: true
    validates :item_id, presence: true
   validates :price, :numericality => {:only_integer => true}

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
    #Cacluate difference
    def gain    
      self.gain_price > 0
    end

    #to caculate the gain amount
    def gain_price(current_price = nil)
      price = self.price.present? ? self.price : 0.0
      current_price = current_price.present? ? current_price : self.item.current_price
      (current_price - price )
    end
    #to caculate the loss amount
    def loss_price(current_price = nil)
      price = self.price.present? ? self.price : 0.0
      current_price = current_price.present? ? current_price : self.item.current_price
      (price - current_price )
    end
    #to caculate the profit %
    def profit_percent(current_price)
      price = self.price.present? ? self.price : 0.0
      (self.gain_price(current_price)*100/current_price).round(2)
    end
    #to caculate the loss %
    def loss_percent(current_price)
      price = self.price.present? ? self.price : 0.0
      (self.loss_price(current_price)*100/price).round(2)
    end
end