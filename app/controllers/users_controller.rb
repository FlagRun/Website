class UsersController < ApplicationController


  def index
    @users = User.all
  end

  def show
    @user = User.friendly.find params[:id]

  end

  def update
    @user = User.friendly.find params[:id]
    authorize @user, :update?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def edit
    @user = User.friendly.find params[:id]
    authorize @user, :edit?

  end

  def password
    @user = User.friendly.find params[:user_id]
    authorize @user, :edit?
  end

  def destroy

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    if current_user.netadmin? || current_user.admin?
      params.require(:user).permit(:email, :username, :status, :password, :password_confirmation, :title)
    else
      params.require(:user).permit(:email, :password, :password_confirmation, :title)
    end
  end

end
