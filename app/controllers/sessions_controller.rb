class SessionsController < ApplicationController

  def new
    @session = Session.new
  end

  def create
    @session = Session.new(params[:session][:username], params[:session][:password])
    if @session.user
      session[:user_id] = @session.user.id
      redirect_to :root
    else
      flash.now[:error] = "Unknown username or password, please try again"
      render :new
    end
  end

  def edit
    session.delete :user_id
    redirect_to :root
  end

end
