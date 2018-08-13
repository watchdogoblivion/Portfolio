class TopicsController < ApplicationController

  before_action :set_topic, only: [:show, :update, :destroy]
  before_action :set_sidebar_topics, only: [:index, :show, :edit]
  layout "blog"
  access all: [:show, :index], user: {except: [:destroy, :create, :update]}, site_admin: :all

  def index
    if logged_in?(:site_admin)
      @topics = Topic.all.recent 
    else
      @topics = Topic.all.recent.with_blogs      
    end
  
  end

  def show
    if logged_in?(:site_admin)
      @blogs = @topic.blogs.recent.page(params[:page]).per(5)
    else
      @blogs = @topic.blogs.recent.published.page(params[:page]).per(5)      
    end
  end

  def edit
    @topics = Topic.all   
    @topic = Topic.new  
  end

  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topics_url, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topics_url, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:title)
    end

    def set_sidebar_topics
    if logged_in?(:site_admin)
      @side_bar_topics = Topic.all
    else
      @side_bar_topics = Topic.with_blogs      
    end
      
    end

end