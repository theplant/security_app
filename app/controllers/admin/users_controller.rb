class Admin::UsersController < ApplicationController

  def index
    filter = params[:filter] || "1=1"
    @users = User.where(filter)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted."
    redirect_to admin_users_path
  end

end
