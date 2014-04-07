class System::NewsController < ApplicationController
  before_action :set_system_news, only: [:show, :edit, :update, :destroy]

  # GET /system/news
  # GET /system/news.json
  def index
    @system_news = System::News.all.order('created_at DESC').page(params[:page]).per(50)
    authorize @system_news, :index?
  end

  # GET /system/news/1
  # GET /system/news/1.json
  def show
    authorize @system_news, :show?
  end

  # GET /system/news/new
  def new
    @system_news = System::News.new
    authorize @system_news, :new?
  end

  # GET /system/news/1/edit
  def edit
  end

  # POST /system/news
  # POST /system/news.json
  def create
    @system_news = System::News.new(system_news_params)
    @system_news.user = current_user
    authorize @system_news, :create?
    respond_to do |format|
      if @system_news.save
        format.html { redirect_to @system_news, notice: 'News was successfully created.' }
        format.json { render action: 'show', status: :created, location: @system_news }
      else
        format.html { render action: 'new' }
        format.json { render json: @system_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /system/news/1
  # PATCH/PUT /system/news/1.json
  def update
    authorize @system_news, :update?
    respond_to do |format|
      if @system_news.update(system_news_params)
        format.html { redirect_to @system_news, notice: 'News was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @system_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /system/news/1
  # DELETE /system/news/1.json
  def destroy
    authorize @system_news, :destroy?
    @system_news.destroy
    respond_to do |format|
      format.html { redirect_to system_news_index_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_system_news
      @system_news = System::News.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def system_news_params
      params.require(:system_news).permit(:title, :user_id, :oline, :published_at, :tags, :body)
    end
end
