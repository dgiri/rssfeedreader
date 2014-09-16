require 'rss'
require 'open-uri'

url = 'http://rss.news.yahoo.com/rss/entertainment'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  feed.items.each do |item|
    puts "Item: #{item.title}"
  end
end

<h1>Welcome to RSS feed reader</h1>

<%= form_tag("/feedlist", method: "get", remote: true) do %>
  <%= label_tag(:url, "Display feeds from url with Ruby RSS parser:") %><br/>
  <%= text_field_tag(:url,'', :size => 80, :id => "simplerssurl") %>
  <%= submit_tag("Check", :id => "submit_simplerssurl" ) %>
<% end %>

<h1>OR</h1>

<%= form_tag("/withfeedjira", method: "get", remote: true) do %>
  <%= label_tag(:url, "Display feeds from url with feedjira gem:") %><br/>
  <%= text_field_tag(:url,'', :size => 80, :id => "rsswithfeedjira") %>
  <%= submit_tag("Check", :id => "submit_rsswithfeedjira") %>
<% end %>
<br/>

<div id="feed_container"></div>

	def index
		require 'rss'
		require 'open-uri'

		if params[:url] && !params[:url].blank?
			url = params[:url]
			# example url http://rss.news.yahoo.com/rss/entertainment / https://www.ruby-lang.org/en/feeds/news.rss / http://news.google.com/?output=rss

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
		require 'feedjira'
		
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




	<h1>Listing rssfeeds</h1>

<table>
  <tr>
    <th>Feedurl</th>
    <th></th>
    <th></th>
    <th></th>
  </tr>

<% @rssfeeds.each do |rssfeed| %>
  <tr>
    <td><%= rssfeed.feedurl %></td>
    <td><%= link_to 'Show', rssfeed %></td>
    <td><%= link_to 'Edit', edit_rssfeed_path(rssfeed) %></td>
    <td><%= link_to 'Destroy', rssfeed, method: :delete, data: { confirm: 'Are you sure?' } %></td>
  </tr>
<% end %>
</table>

<br />

<%= link_to 'New Rssfeed', new_rssfeed_path %>
	