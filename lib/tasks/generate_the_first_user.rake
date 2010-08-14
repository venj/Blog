namespace :blog do
  desc "Initialize the blog application"
  task :init => :environment do
    if User.all.blank?
      User.create!(:name => 'koz', :nickname => "Koz", :email => "koz.masumitsu@gmail.com",
                  :password => "123456", :password_confirmation => "123456")
      user = User.first
      user.posts.create!(:title => "Hello world", 
        :url => "my-first-blog-post",
        :post_tags => "Blog",
        :content => "<p>This is a sample post, you can edit this post or simply delete it and start your own.</p><p>Happy blogging!</p>")
    else
      puts "You've already initialized this application."
    end
  end
end