class AddColumnUserIdToRssfeeds < ActiveRecord::Migration
  def change
  	add_column :rssfeeds, :user_id, :integer
  end
end
