$KCODE='u'
require 'jcode'
require 'digest/md5'
class Comment < ActiveRecord::Base
  belongs_to :post
  before_create :check_for_spam
  
  validates_presence_of :commenter, :email, :content
  
  named_scope :approved, :conditions => {:approved => true}
  
  def gravatar
    email_address = email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    "http://www.gravatar.com/avatar/#{hash}?s=48&d=mm"
  end
  
  def request=(request)
    self.user_ip = request.remote_ip
    self.user_agent = request.env['HTTP_USER_AGENT']
    self.user_referrer = request.env['HTTP_REFERER']
  end
  
  def check_for_spam
    self.approved = !Akismetor.spam?(akismet_attributes)
    true
  end
  
  def akismet_attributes
    {
      :key => "bd58c407baf7",
      :blog => "http://blog.wxtengu.net/",
      :user_ip => user_ip,
      :user_agent => user_agent,
      :referrer => user_referrer,
      :comment_author => commenter,
      :comment_author_email => email,
      :comment_author_url => website,
      :comment_content => content
    }
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
  
  def mark_as_spam!
    update_attribute(:approved, false)
    Akismetor.submit_spam(akismet_attributes)
  end
  
  def mark_as_ham!
    update_attribute(:approved, true)
    Akismetor.submit_ham(akismet_attributes)
  end
  
end
