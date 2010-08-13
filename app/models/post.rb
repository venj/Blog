$KCODE='u'
require 'jcode'
class Post < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 6
  
  belongs_to :user
  has_many :tags, :through => :taggings
  has_many :taggings, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  def self.search(search, page)
    if search
      paginate :page => page, :order => 'created_at DESC', :conditions => ["title LIKE ? OR content LIKE ?", "%#{search}%", "%#{search}%"]
    else
      paginate :page => page, :order => 'created_at DESC'
    end
  end
  
  def text_content
    content.gsub(/(\s|<\/?[^>]*>)/, "")
  end
  
  def short_content
    str = ''
    count = 0
    text_content.each_char do |c|
      break if count > 30
      count = count + 1
      str = str + c
    end
    str + "..."
  end
  
  def post_tags
    tags.collect(&:name).join(", ")
  end
  
  def post_tags=(str)
    tokens = str.split(",").collect(&:strip)
    p_tags = []
    tokens.each do |token|
      next if token.blank?
      tag = Tag.find_or_create_by_name(token.capitalize)
      tag.url = CGI.escape(token.downcase)
      tag.save
      p_tags << tag
    end
    self.tags = p_tags
  end
  
end
