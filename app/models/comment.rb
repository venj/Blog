$KCODE='u'
require 'jcode'
require 'digest/md5'
class Comment < ActiveRecord::Base
  belongs_to :post
  
  validates_presence_of :commenter, :email, :content
  
  def gravatar
    email_address = email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    "http://www.gravatar.com/avatar/#{hash}?s=48&d=mm"
  end
  
  def short_content
    str = ''
    count = 0
    #content.gsub!(/(\s|<\/?[^>]*>)/, "")
    content.each_char do |c|
      break if count > 10
      count = count + 1
      str = str + c
    end
    str + "..."
  end
  
end
