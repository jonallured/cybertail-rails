class AddBookmarkedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bookmarked_at, :timestamp
  end
end
