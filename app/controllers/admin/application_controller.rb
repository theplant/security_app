class Admin::ApplicationController < ::ApplicationController

  before_filter :validate_role

  def validate_role
    redirect_to root_path unless current_user && current_user.role == "admin"
  end

end
