# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_user
    User.find_by_id(session[:user_id])
  end
  
  def latest_posts
    Post.find(:all, :limit => 5, :order => "created_at DESC")
  end
  
  def latest_comments
    Comment.find(:all, :limit => 5, :order => "created_at DESC")
  end
  
  def admin
    User.first
  end
  
  def blog_title
    "#{admin.show_name}" + t('helper.blog')
  end
  
  def subtitle
    t('helper.subtitle')
  end
  
end
