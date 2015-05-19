class Session < Struct.new(:username, :password)
  def self.model_name; ActiveModel::Name.new(Session); end

  def user
    user = User.where(username: username).first
    user if user && user.password == password
  end

  def to_key
    ["session"]
  end

end
