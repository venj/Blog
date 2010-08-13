require 'digest/sha1'

module Authorizable

  # Create a hashed string from password and salt
  def hashed_password(password, salt)
    d = Digest::SHA1.new
    d.update(password)
    d.update(salt)
    d.hexdigest
  end

  # Create a random string with Digest::SHA1
  def create_salt
    d = Digest::SHA1.new
    now = Time.now
    d.update(now.to_s)
    d.update(String(now.usec))
    d.update(String(rand(0)))
    d.update(String($$))
    d.update('wxtengu.net')
    d.hexdigest
  end
end