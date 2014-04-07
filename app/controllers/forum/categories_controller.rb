class Forum::CategoriesController < ApplicationController
  #authorize_resource :category, except: [:index]

  def index
    # @categories = Forum::Category.includes(:forums).load
    @categories = policy_scope(Forum::Category).includes(:forums).load
    authorize @categories, :index?
  end
  
  def new
    @category = Forum::Category.new
    authorize @category, :create?
  end
  
  def create
    @category = Forum::Category.new(permitted_params)
    authorize @category, :create?

    if @category.save
      flash[:notice] = "Category was successfully created."
      redirect_to forum_forums_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Forum::Category.find(params[:id])
    authorize @category, :update?
  end
  
  def update

    @category = Forum::Category.find(params[:id])
    authorize @category, :update?

    if @category.update_attributes(permitted_params)
      flash[:notice] = "Category was updated successfully."
      redirect_to forum_forums_url
    end
  end
  
  def destroy

    @category = Forum::Category.find(params[:id])
    authorize @category, :destroy?

    if @category.destroy
      flash[:notice] = "Category was deleted."
      redirect_to forum_forums_url
    end
  end

  private

    def permitted_params
      params.require(:forum_category).permit(:title, :state, :position, :category_id, :oline, :status)
    end

end