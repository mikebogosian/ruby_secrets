class SessionsController < ApplicationController
  def index
  end


  def new
  end

  def create

  	u = User.find_by(email: params[:email])
  	if u && u.authenticate(params[:password])
  		session[:user_id] = u.id
  		redirect_to "/users/#{u.id}"
  	else
  	flash[:errors] = ["Invalid Email & Password Combination"]
  	redirect_to :back
  	end
  end

  def show
  	@user = User.find(params[:id])
  end

  def destroy
  	reset_session
  	redirect_to '/sessions/new'
  end




end
