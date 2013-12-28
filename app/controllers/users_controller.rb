class UsersController < ApplicationController

  def index
    @users = User.order('followers_count DESC').limit(10)
  end

  def refresh
    require 'open-uri'


    page = Nokogiri::HTML(open('http://twitaholic.com/top100/followers/'))
    links =  page.css('html body div#container div#mainspace div#therest table tbody tr td.statcol_name a')
    screen_names = []
    links.each { |x| screen_names << x["href"].sub(/\//, "").chomp('/') }
    twitter_client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    User.destroy_all
    # get all users by screen names
    twitter_client.users(screen_names).each do |twitter_user|
      begin
        user = User.create(name: twitter_user.name,screen_name: twitter_user.screen_name,twitter_id: twitter_user.id,followers_count: twitter_user.followers_count )
        # retrieve followers of the user
        followers = twitter_client.followers(user.twitter_id,count: 5 )
        followers.each do |follower|
          follower_user = User.create(name: follower.name,screen_name: follower.screen_name,twitter_id: follower.id,followers_count: follower.followers_count )
          user.followables.create(follower_id: follower_user.id)
        end
      rescue  Twitter::Error
        logger.error "Rate limit exceeds"
        retry
      end
    end
  end

  def followers
    @user = User.where(screen_name: params[:screen_name]).first
    @followers = @user.followers.order('followers_count DESC')
  end

end
