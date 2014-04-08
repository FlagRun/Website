class Forum::PostsController < ApplicationController
  before_filter :authenticate_user!
  #authorize_resource :topic
  #authorize_resource :post, :through => :topic, :shallow => true

  def new
    @forum = Forum::Forum.friendly.find(params[:forum_id])
    @topic = Forum::Topic.friendly.find(params[:topic_id])
    @post = @topic.posts.new
    authorize @post, :new?

    if @topic.forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    if params[:quote]
      quote_post = Forum::Post.find(params[:quote])
      if quote_post
        @post.body = '>'+quote_post.body
      end
    end
  end
  
  def create
    @topic = Forum::Topic.friendly.find(params[:topic_id])
    @post = @topic.posts.build(permitted_params)
    @post.forum = @topic.forum
    @post.user = current_user
    authorize @post, :create?

    if @post.forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    if @post.save
      flash[:notice] = 'Post was successfully created.'
      redirect_to forum_topic_path(@post.topic.forum, @post.topic)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @post = Forum::Post.find(params[:id])
    @forum = @post.forum
    @topic = @post.topic
    authorize @post, :edit?

    if @post.forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

  end
  
  def update
    @post = Forum::Post.find(params[:id])
    @forum = @post.forum
    @topic = @post.topic
    authorize @post, :update?

    if @post.forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    if @post.update_attributes(permitted_params)
      flash[:notice] = 'Post was successfully updated.'
      redirect_to forum_topic_path(@post.topic.forum, @post.topic)
    end
  end
  
  def destroy
    @post = Forum::Post.find(params[:id])
    authorize @post, :destroy?

    if @post.forum.oline != 0 && !current_user.netadmin?
      raise Pundit::NotAuthorizedError.new('Authorization missing or Record not found')
    end

    if @post.topic.posts_count > 1
      if @post.destroy
        flash[:notice] = "Post was successfully destroyed."
        redirect_to forum_topic_path(@post.topic.forum,@post.topic)
      end
    else
      if @post.topic.destroy
        flash[:notice] = "Topic was successfully deleted."
        redirect_to forum_forum_path(@post.forum)
      end
    end
  end

  private

    def permitted_params
      params.require(:forum_post).permit(:body)
    end

end