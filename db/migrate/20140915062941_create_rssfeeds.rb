class CreateRssfeeds < ActiveRecord::Migration
  def change
    create_table :rssfeeds do |t|
      t.string :feedurl

      t.timestamps
    end
  end
end
