class UsersController < ApplicationController
  def show
  end

  def create
    user = User.new name: 'shen'
    if user.save
      p 'success'
      render json: user
    else
      render json: user.errors
    end
  end
end
