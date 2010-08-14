class AddIndexOnTitleAndContentToPosts < ActiveRecord::Migration
  def self.up
    add_index :posts, [:title, :content]
  end

  def self.down
    remove_index :posts, :column => [:title, :content]
  end
end
