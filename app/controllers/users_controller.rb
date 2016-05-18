class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  	@user = User.find(params[:id])

    @secrets = User.find(params[:id]).secrets
  end

  def create
  	u = User.new(user_params)
  	if u.save
      session[:user_id] = u.id
  		redirect_to "/users/#{u.id}"
  	else
  		flash[:errors] = ["Input field can't be blank","This is an invalid input" ]
  		redirect_to '/users/new'
  	end
  	
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	user = User.find(params[:id])
  	user.name = params[:name]
  	if user.save
  		redirect_to "/users/#{user.id}"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/users/#{user.id}/edit"
  	end

  end


  def new
  	
  end

	def destroy
 	user = User.find(params[:id])
 	user.destroy
  session[:user_id] = nil
  	
 	redirect_to '/users/new'
  end


  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
