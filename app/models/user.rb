class User < ActiveRecord::Base
  attr_accessible :name,:followers_count, :screen_name, :twitter_id
  validates :screen_name,:twitter_id, uniqueness: true ,allow_blank: true,allow_nil: true


  has_many :followables    ,dependent: :destroy
  has_many :followers, through: :followables


end
