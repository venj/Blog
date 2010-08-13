class CommentsController < ApplicationController
  before_filter :logged_in, :only => :destroy
  
  def create
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_url(params[:post_id])
    params[:comment][:content].gsub!(/(\s|<\/?[^>]*>)/, "")
    @comment = @post.comments.create!(params[:comment])
    
    respond_to do |format|
      format.html { redirect_to @post}
      format.js
    end
  end
  
  def destroy
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_url(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    
    redirect_to @post
  end

end
