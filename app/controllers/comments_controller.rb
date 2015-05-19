class CommentsController < ApplicationController

  def create
    @comment = current_user.comments.new params[:comment]
    if @comment.save
      flash[:notice] = "Posted your comment!"
      redirect_to cat_path(@comment.cat.sub(".", "%252e"))
    else
      flash.now[:error] = @comment.errors.full_messages.to_sentence
      @cat = @comment.cat
      render "cats/show"
    end
  end
end
