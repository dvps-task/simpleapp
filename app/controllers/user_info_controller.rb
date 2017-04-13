class UserInfoController < ApplicationController
  def index
    @ip = request.ip
    @user_agent = request.user_agent
  end
end
