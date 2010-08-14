class AddIndexOnTitleAndContentToPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, :title
    add_index :posts, :content
  end

  def self.down
    remove_index :posts, :content
    remove_index :posts, :title
  end
end
