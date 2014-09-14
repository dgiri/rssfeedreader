class RssfeedsController < ApplicationController
	require 'rss'
	require 'open-uri'
	require 'feedjira'

	def index
		if params[:url] && !params[:url].blank?
			url = params[:url]
			# example url http://rss.news.yahoo.com/rss/entertainment / https://www.ruby-lang.org/en/feeds/news.rss

			@rssitems = []
			begin
				open(url) do |rss|
				  feed = RSS::Parser.parse(rss)
				  @title = feed.channel.title

				  feed.items.each do |item|
				  	@rssitems << item
				  end
				end
			rescue => error
			  @errors = "Url are not proper."
			end
		end
		respond_to do |format|
	      format.html # index.html.erb
	      format.js {}
	  end
	end

	def withfeedjira
		if params[:url] && !params[:url].blank?
			url = params[:url]
			begin
				feed = Feedjira::Feed.fetch_and_parse url
				unless feed == 0
					@title = feed.title
					@rssitems = feed.entries
				else
					@error = "Input url is not valid."
				end
			rescue => error
			  @errors = "Url are not proper."
			end
		end

		respond_to do |format|
	      format.html # index.html.erb
	      format.js {}
	  end
	end
end
