class PostsController < ApplicationController
  before_filter :logged_in, :except => [:index, :show]
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.search(params[:search], params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.js
      format.atom
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find_by_id(params[:id]) || Post.find_by_url(params[:id])
    @comments = @post.comments.all(:order => "created_at DESC")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @user = User.find(session[:user_id])
    @post = @user.posts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @user = User.find(session[:user_id])
    @post = @user.posts.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to("/#{@post.url}", :notice => t('controller.created')) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to("/#{@post.url}", :notice => t('controller.updated')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(root_path, :notice => t('controller.deleted')) }
      format.xml  { head :ok }
    end
  end
end
