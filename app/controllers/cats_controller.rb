class CatsController < ApplicationController

  def index
    @cats = Dir.glob(Rails.root.join("cats", "*")).map(&File.method(:basename))
  end

  def show
    @cat = URI.unescape params[:id]
    
    @comment = Comment.new cat: @cat

    @comments = Comment.where("cat = '#{@cat}'")
  end

  def image
    @cat = params[:cat]
    filename = cat_dir.join @cat
    if filename.dirname == cat_dir # only allow cats to be downloaded!
      send_file filename, disposition: "inline"
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

  def cat_dir
    Rails.root.join("cats")
  end
end
