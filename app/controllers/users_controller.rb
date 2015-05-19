class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      session[:user_id] = @user.id
      redirect_to cats_path
    else
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end
end
