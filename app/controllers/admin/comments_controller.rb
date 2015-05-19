class Admin::CommentsController < Admin::ApplicationController
  
  def destroy
    comment = ::Comment.find(params[:id])
    cat = comment.cat
    comment.destroy
    flash[:notice] = "Comment deleted."
    redirect_to admin_cat_path(cat.sub(".", "%252e"))
  end
  
end
