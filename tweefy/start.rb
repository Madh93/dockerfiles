#! /usr/bin/env ruby

require 'yaml'
require 'net/http'
require 'json'
require 'shorturl'
require 'twitter'
require 'yt'

# CONFIGURATION
config = YAML.load_file('secrets.yaml')

# Twitter
TWITTER_CONSUMER_KEY = config['twitter-consumer-key']
TWITTER_CONSUMER_SECRET = config['twitter-consumer-secret']
TWITTER_ACCESS_TOKEN = config['twitter-access-token']
TWITTER_ACCESS_TOKEN_SECRET = config['twitter-access-token-secret']
TWITTER_USERNAME = config['twitter-username']

# Youtube
YOUTUBE_API_KEY = config['youtube-api-key']

# LastFM
LASTFM_API_KEY = config['lastfm-api-key']
LASTFM_USERNAME = config['lastfm-username']

class TwitterClient
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = TWITTER_CONSUMER_KEY
      config.consumer_secret     = TWITTER_CONSUMER_SECRET
      config.access_token        = TWITTER_ACCESS_TOKEN
      config.access_token_secret = TWITTER_ACCESS_TOKEN_SECRET
    end
  end

  def update(tweet)
    @client.update(tweet)
  end

  def created
    @client.user_timeline(TWITTER_USERNAME, count: 1).first.created_at
  end
end

class YoutubeVideo
  def self.link(*info)
    Yt.configure do |config|
      config.api_key = YOUTUBE_API_KEY
    end
    videos = Yt::Collections::Videos.new
    id = videos.where(q: info.join(' '), order: 'relevance').first.id
    "https://youtu.be/#{id}"
  end
end

class LastFMTrack
  attr_reader :name, :artist, :url, :video

  def initialize
    url = "http://ws.audioscrobbler.com/2.0/" \
          "?method=user.getrecenttracks&format=json&limit=1" \
          "&user=#{LASTFM_USERNAME}&api_key=#{LASTFM_API_KEY}"
    response = Net::HTTP.get(URI(url))
    data = JSON.parse(response)

    @name = data['recenttracks']['track'][0]['name']
    @artist = data['recenttracks']['track'][0]['artist']['#text']
    @url = ShortURL.shorten(data['recenttracks']['track'][0]['url'], :tinyurl)
    @video = YoutubeVideo.link(@name, @artist)
  end

  def message
    "#NowPlaying \"#{@name}\" by #{@artist} ♫ #{@url} #{@video}"
  end
end

class Tweefy
  def initialize
    @twitter = TwitterClient.new
    @track = LastFMTrack.new
  end

  def tweet
    if !@track.name.nil?
      @twitter.update(@track.message) unless @twitter.created.day == Time.now.day
    else
      puts "Cancion desconocida"
    end
  end

  def now
    if !@track.name.nil?
      puts @track.message
    else
      puts "Cancion desconocida"
    end
  end
end

tweefy = Tweefy.new
tweefy.now
if (ARGV.first == 'push')
  tweefy.tweet
end
