class Rssfeed < ActiveRecord::Base
  attr_accessible :feedurl
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  validates_presence_of :feedurl
  validates_uniqueness_of :feedurl, :message => "is already added."
  validate :validurl

  per_page = 1

	def validurl
		begin
			open(self.feedurl) do |rss|
			  feed = RSS::Parser.parse(rss)
			  @title = feed.channel.title
			  if @title.blank?
			  	errors.add(:feedurl, "is not valid.")
			  else
			  	true
			  end
			end
		rescue => error
			errors.add(:feedurl, "is not valid.")
		end
	end
end
