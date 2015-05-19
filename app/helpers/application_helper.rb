module ApplicationHelper
  def exif cat
    filename = Rails.root.join "cats", cat
    `identify #{filename}`.chomp
  end
end
