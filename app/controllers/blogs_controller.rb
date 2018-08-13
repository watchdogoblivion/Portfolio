class BlogsController < ApplicationController

  before_action :set_blog, only: [:show, :edit, :update, :destroy, :toggle_status, :toggle_featured]
  before_action :set_featured, only:[:index, :update, :published_blogs, :drafted_blogs, :toggle_featured]
  before_action :set_sidebar_topics, except: [ :toggle_status, :destroy]
  access all: [:show, :index], 
         user: {except: [:destroy, :new, :create, :update, :edit, :toggle_status, :toggle_featured]}, 
         site_admin: :all
  layout "blog"



  # GET /blogs
  # GET /blogs.json
  def index
    if logged_in?(:site_admin)
      @blogs = Blog.recent.page(params[:page]).per(5)
    else
      @blogs = Blog.recent.published.page(params[:page]).per(5)      
    end
    @page_title = "My Portfolio Blog"

  end

  def published_blogs
    @blogs = Blog.published_blogs.recent.page(params[:page]).per(5)
  end

  def drafted_blogs
    @blogs = Blog.drafted_blogs.recent.page(params[:page]).per(5)
    @featured_blogs = Blog.drafted_blogs
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
     if logged_in?(:site_admin) || @blog.published?
      @blog = Blog.includes(:comments).friendly.find(params[:id])
      @comment = Comment.new
      @page_title = @blog.title
      @seo_keywords = @blog.body
    else
      redirect_to blogs_path, notice: "You are not authorized to access this page"
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        feature
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: 'Blog was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_status
  
    if @blog.draft?
       @blog.published!
    elsif @blog.published?
       @blog.draft!
    end
  redirect_to request.referrer, notice: 'Blog status successfully updated.'
 #redirect_back(fallback_location: fallback_location)
 #redirect_to blogs_path, notice: 'Blog status successfully updated.'
    
  end

  def toggle_featured
    @featured_blogs = Blog.all
    
    if @blog.not_featured?
      @featured_blogs.each do |blog|
        blog.not_featured!
      end
       @blog.featured!
    elsif @blog.featured?
       @blog.not_featured!
    end
      redirect_to request.referrer, notice: 'Blog status successfully updated.'
      #redirect_to blogs_path, notice: 'Blog feature successfully updated.'
  end

  def path_to_url(path)
    "#{request.protocol}#{request.host_with_port.sub(/:80$/,"")}/#{path.sub(/^\//,"")}"
  end

  private

    def feature
      unless @blog.not_featured?
        @featured_blogs.each do |blog|
          unless @blog == blog
            blog.not_featured!
          end
        end
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.friendly.find(params[:id])
    end

    def set_featured
      @featured_blogs = Blog.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :body, :topic_id, :status, :featured)
    end

    def set_sidebar_topics
    if logged_in?(:site_admin)
      @side_bar_topics = Topic.all
    else
      @side_bar_topics = Topic.with_blogs      
    end
      
    end

end
