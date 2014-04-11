class Forum::TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  #authorize_resource :forum
  #authorize_resource :topic, :through => :forum, :shallow => false

  def show
    @forum = Forum::Forum.friendly.find(params[:forum_id])
    @topic = Forum::Topic.find(params[:id])
    @posts = @topic.posts.page(params[:page]).per(50)

    authorize @forum, :show?
    authorize @topic, :show?

    if @topic.forum.oline != 0 && !current_user.netadmin?
      Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    @topic.hit! if @topic
    @topic.mark_as_read!(:for => current_user) if user_signed_in?
  end
  
  def new
    @forum = Forum::Forum.friendly.find(params[:forum_id])
    @topic = Forum::Topic.new
    authorize @forum, :show?
    authorize @topic, :new?
    # @topic = Forum::Forum
   if @forum.oline != 0 && !current_user.netadmin?
     raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
   end

  end
  
  def create
    @forum = Forum::Forum.friendly.find(params[:forum_id])
    @topic = @forum.topics.build(permitted_params)
    @topic.user = current_user
    authorize @forum, :show?
    authorize @topic, :create?

    if @forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    if @topic.save
      flash[:notice] = 'Topic was successfully created.'
      redirect_to forum_topic_url(@forum, @topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum = Forum::Forum.friendly.find(params[:forum_id])
    @topic = Forum::Topic.friendly.find(params[:id])
    authorize @forum, :show?
    authorize @topic, :edit?
    if @topic.forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end
  end
  
  def update
    @topic = Forum::Topic.find(params[:id])
    @forum = @topic.forum
    authorize @forum, :show?
    authorize @topic, :update?

    if @forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    if @topic.update_attributes(permitted_params)
      flash[:notice] = 'Topic was updated successfully.'
      redirect_to forum_topic_url(@topic.forum, @topic)
    end
  end

  def destroy
    @topic = Forum::Topic.find(params[:id])
    authorize @topic.forum, :show?
    authorize @topic, :destroy?

    if @topic.destroy
      flash[:notice] = 'Topic was deleted successfully.'
      redirect_to forum_forum_url(@topic.forum)
    end
  end

  def move
    @topic = Forum::Topic.friendly.find params[:id]
    authorize @topic, :edit?

  end


  private

    def permitted_params
      if user_signed_in? && (current_user.helper? || current_user.op? || current_user.admin? || current_user.netadmin?)
        params.require(:forum_topic).permit(:title, :body, :sticky, :locked, :forum_id, :deleted_at)
      else
        params.require(:forum_topic).permit(:title, :body, :sticky, :locked, :deleted_at)
      end
    end

end
