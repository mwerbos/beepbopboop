class UserSession < Authlogic::Session::Base
  attr_accessible :login, :password
  # attr_accessible :title, :body
end
