class Admin::CatsController < Admin::ApplicationController
  
  def index
    @cats = `ls #{Rails.root}/cats`.chomp.split
  end

  def show
    @cat = URI.unescape params[:id]
    
    @comments = ::Comment.where("cat = '#{@cat}'")
  end

  def image
    @cat = params[:cat]
    filename = Rails.root.join "cats", @cat
    send_file filename, disposition: "inline"
  end

end
