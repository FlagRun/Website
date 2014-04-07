class Forum::ForumsController < ApplicationController
  #authorize_resource :category
  #authorize_resource :forum, :through => :category, :shallow => true


  def show
    # @forum = Forum::Forum.find(params[:id])
    @forum = policy_scope(Forum::Forum).friendly.find(params[:id])
    @topics = @forum.topics.page(params[:page]).per(50)
    authorize @forum, :show?
  end
  
  def new
    @forum = Forum::Forum.new
    authorize @forum, :new?

  end
  
  def create
    @forum = Forum::Forum.new(permitted_params)
    authorize @forum, :create?

    if @forum.save
      flash[:notice] = "Forum was successfully created."
      redirect_to forum_forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @forum = Forum::Forum.friendly.find(params[:id])
    authorize @forum, :edit?
  end
  
  def update
    @forum = Forum::Forum.friendly.find(params[:id])
    authorize @forum, :update?

    if @forum.update_attributes(permitted_params)
      flash[:notice] = "Forum was updated successfully."
      redirect_to forum_forum_url(@forum)
    end
  end
  
  def destroy
    @forum = Forum::Forum.friendly.find(params[:id])
    authorize @forum, :destroy?

    if @forum.destroy
      flash[:notice] = "Category was deleted."
      redirect_to forum_forums_url
    end
  end

  def readall
    @forum = Forum::Forum.friendly.find(params[:forum_id])
    if @forum.topics.mark_as_read! :all, :for => current_user
      flash[:notice] = 'All Topics Marked as Read!'
      redirect_to forum_forum_url(@forum)
    end
  end

  private

    def permitted_params
      if user_signed_in? && (current_user.helper? || current_user.op? || current_user.admin? || current_user.netadmin?)
        params.require(:forum_forum).permit(:title, :description, :state, :position, :category_id, :oline, :status)
      else
        params.require(:forum_forum).permit(:title, :description, :state, :position, :category_id)
      end
    end
end