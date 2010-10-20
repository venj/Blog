class CommentsController < ApplicationController
  before_filter :logged_in, :only => [:destroy, :destroy_multiple]
  
  def create
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_url(params[:post_id])
    params[:comment][:content].gsub!(/(<\/?[^>]*>)/, "")
    @comment = @post.comments.new(params[:comment])
    @comment.request = request
    
    respond_to do |format|
      if @comment.save
        if @comment.approved?
          format.html { redirect_to "/#{@post.url}" }
          format.js
        else
          format.html { redirect_to "/#{@post.url}", :notice => t('controller.update_verify') }
          format.js
        end
      end
    end
  end
  
  def destroy
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_url(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    
    redirect_to @post
  end
  
  def destroy_multiple
      Comment.destroy_all({ :approved => false })
      flash[:notice] = t('comments.spam_deleted')
      redirect_to root_path
  end
  
  def approve
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_url(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.mark_as_ham!
    redirect_to "/#{@post.url}"
  end
  
  def reject
    @post = Post.find_by_id(params[:post_id]) || Post.find_by_url(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.mark_as_spam!
    redirect_to "/#{@post.url}"
  end

end
