class PostsController < ApplicationController
  before_action :require_login, except: [:index, :show, :page, :list]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :check_permission, only: [:update, :destroy]
  before_action :set_list, only: [:index, :show, :list] # used to display posts list in side_panel partial view
  before_action :set_articles, only: [:index, :page] # posts to display in <main>

  helper_method :author_of?

  ARTICLE_COUNT_PER_PAGE = 5
  LIST_COUNT_PER_PAGE = 10

  def page
    respond_to do |format|
      format.js { render :page, content_type: "text/html" }
    end
  end

  def list
    respond_to do |format|
      format.js { render partial: 'post_list', content_type: "text/html" }
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    respond_to do |format|
      format.html {}
      format.js { render :index,  content_type: "text/html" }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def check_permission
      unless author_of? @post
        unless params[:action] == "destroy" && admin?
          redirect_to root_path, alert: "Permission denied"
        end
      end
    end

    def set_list
      @list = Post.select(:id, :title).order(created_at: :desc).page(params[:list_page]).per(LIST_COUNT_PER_PAGE)
    end

    def set_articles
      @articles = Post.order(created_at: :desc).page(params[:page]).per(ARTICLE_COUNT_PER_PAGE)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end

    #helper methods
    def author_of? article
      current_user == article.user
    end
end
